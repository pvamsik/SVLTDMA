using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CommonDTO;
using System.IO;
using AuthorizeNet.Api.Controllers;
using AuthorizeNet.Api.Contracts.V1;
using AuthorizeNet.Api.Controllers.Bases;
using System.Data.Entity;
using CommonDTO.Entities;

public partial class devotee_orderDetails : BasePage
{
    int orderId;
    Order order;
    List<OrderItem> orderItemsList;
    ICollection<OrderItem> orderItemsCollection;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Request.QueryString["orderId"]))
            Response.Redirect("~/devotee/searchDevotee.aspx");

        string orderIdstring = Request.QueryString["orderId"];
        getOrderDetails(orderIdstring);

        if (!IsPostBack)
        {
            pnlErrorMessage.Visible = false;
            if (order != null || orderItemsList != null)
            {
                List<Order> orderList = new List<Order>();
                orderList.Add(order);
                rptOrderDetails.DataSource = orderList;
                rptOrderDetails.DataBind();
                gvOrderItems.DataSource = orderItemsList;
                gvOrderItems.DataBind();

                if (order.orderStatus == "Cancelled")
                {
                    //btnEmailOrder.Visible = false;
                    //btnPrintOrder.Visible = false;
                    btnRefundOrder.Visible = false;
                }
            }
            else
            {
                pnlErrorMessage.Visible = true;
                errorMessage.Text = "Unable to find the requested Order. Please try again.";
                btnEmailOrder.Visible = false;
                btnPrintOrder.Visible = false;
                btnRefundOrder.Visible = false;
            }
        }
    }
    protected void gvOrderItems_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            using (OrderEntities context = new OrderEntities())
            {
                var order = context.Orders.FirstOrDefault(c => c.Id == orderId);
                if (order != null)
                {
                    e.Row.Cells[0].Text = "Total";
                    e.Row.Cells[3].Text = string.Format("{0:N0}", order.orderItemCount);
                    e.Row.Cells[4].Text = String.Format("{0:C}", order.orderTotal);
                }
            }
        }
    }
    protected void btnEmailOrder_Click(object sender, EventArgs e)
    {
        Order myOrder = order;
        devoteeInfo di = new devoteeInfo(Convert.ToString(myOrder.devoteeID));
        if ((di.email != "") && (di.email != null))
        {
            //Populate the Email body based on email template and send email
            string header = PopulateHeader(myOrder.orderStatus);
            string body = PopulateBody(di, myOrder);

            EmailProvider ep = new EmailProvider();
            List<string> receivers = new List<string>();
            receivers.Add("receipts@svlotustemple.org");
            string sendEmailResultStatus = ep.sendEmailReceipt(header, body, di.email, receivers);
        }
    }
    protected void btnOrdersList_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/devotee/ordersList.aspx?devoteeId=" + Request.QueryString["devoteeId"]);
    }
    protected void btnPrintOrder_Click(object sender, EventArgs e)
    {
        Order myOrder = order;
        ClientDTO client = getClientInfo(Request.UserHostName);

        if (client.PrinterPort != "")
        {
            printManager pM = new printManager(client.PrinterPort, client.PrinterSettings);
            try
            {
                pM.printReceipt(order);
                //messageDiv.InnerHtml = createMessagePanel("Your receipt was printed", "Success", 1000);
            }
            catch (Exception printException)
            {
                errorMessage.Visible = true;
                errorMessage.Text = printException.Message;
            }
        }
        else
        {
            errorMessage.Visible = true;
            errorMessage.Text = "The computer you are using has not been setup for Printing. Please reachout to an Admin for printing setup";
        }
    }
    protected void btnRefundOrder_Click(object sender, EventArgs e)
    {
        processRefundRequest();
    }
    private void processRefundRequest()
    {
        Order myOrder = order;
        if (myOrder != null)
        {
            try
            {
                if (myOrder.paymentMethodName == "CREDIT CARD")
                {
                    var creditCard = new creditCardType
                    {
                        cardNumber = myOrder.cardNumberMasked,
                        expirationDate = myOrder.cardExpirationMonth // + order.cardExpirationYear
                    };
                    string response = ccProcessor.getTransactionStatus(myOrder.authorizationTransactionId);
                    if (response != "No Action")
                    {
                        //standard api call to retrieve response
                        var paymentType = new paymentType { Item = creditCard };
                        transactionRequestType transactionRequest = new transactionRequestType();
                        switch (response)
                        {
                            case "capturedPendingSettlement":
                                //If the Order has not Settled, Void the Transaction
                                transactionRequest = new transactionRequestType
                                {
                                    transactionType = transactionTypeEnum.voidTransaction.ToString(),    // refund type
                                    payment = paymentType,
                                    refTransId = myOrder.authorizationTransactionId
                                };
                                break;
                            case "settledSuccessfully":
                                //If the Order has Settled, Refund the Transaction
                                transactionRequest = new transactionRequestType
                                {
                                    transactionType = transactionTypeEnum.refundTransaction.ToString(),    // refund type
                                    payment = paymentType,
                                    amount = myOrder.orderTotal,
                                    refTransId = myOrder.authorizationTransactionId
                                };
                                break;
                            default:
                                //If the Order is not pending Settlement or Settled already, the order needs to be managed manually.
                                errorMessage.Text = "This Order cannot be refunded at this time. Please contact the system administrator to process this request";
                                break;
                        }
                        ANetResponse refundResponse = ccProcessor.submitTransaction(paymentType, creditCard, transactionRequest);
                        if (refundResponse.response.messages.resultCode == messageTypeEnum.Ok)
                        {
                            bool res = dbRefundOrder(myOrder);

                            if (res == true)
                                Response.Redirect("~/devotee/orderDetails.aspx?devoteeId=" + myOrder.devoteeID + "&orderId=" + myOrder.Id);
                        }
                    }
                }
                if(myOrder.paymentMethodName != "CREDIT CARD")
                {
                    bool res = dbRefundOrder(myOrder);

                    if (res == true)
                        Response.Redirect("~/devotee/orderDetails.aspx?devoteeId=" + myOrder.devoteeID + "&orderId=" + myOrder.Id);
                }
            }
            catch (Exception ex)
            {
                errorMessage.Text = createErrorMessage(ex.Message, "Error", 3000);
            }
        }
    }
    public bool dbRefundOrder(Order myOrder)
    {
        bool result = false;
        using (OrderEntities context = new OrderEntities())
        {
            try
            {
                Order o = context.Orders.FirstOrDefault(x => x.Id == myOrder.Id);
                o.orderStatus = "Cancelled";
                o.paymentStatus = "Refunded";
                foreach (var orderitem in o.OrderItems.ToList())
                {
                    orderitem.itemStatus = "Refunded";
                }
                context.Entry(o).State = EntityState.Modified;
                context.SaveChanges();
                result = true;
            }
            catch (Exception refundSaveException)
            {
                result = false;
                errorMessage.Text = createErrorMessage(refundSaveException.Message, "Error", 3000);
            }
        }
        return result;
    }
    public void getOrderDetails(string orderID)
    {
        try
        {
            orderId = Convert.ToInt32(orderID);
            if (orderId != 0)
            {
                try
                {
                    using (OrderEntities context = new OrderEntities())
                    {
                        order = context.Orders.SingleOrDefault(x => x.Id == orderId);
                        var myOrder = context.Orders.SingleOrDefault(x => x.Id == orderId);

                        if (order != null || myOrder != null)
                        {
                            List<Order> orderList = new List<Order>();
                            orderList.Add(order);

                            orderItemsCollection = myOrder.OrderItems;
                            orderItemsList = order.OrderItems.ToList();
                        }
                        else
                        {
                            pnlErrorMessage.Visible = true;
                            errorMessage.Text = "Unable to find the requested Order. Please try again.";
                        }
                    }
                }
                catch (Exception ex)
                {
                    pnlErrorMessage.Visible = true;
                    errorMessage.Text = "An Unknown exception has happened in the system. Please contact the System Administrator for further support.";
                }
            }
        }
        catch (Exception ex)
        {
            if (ex is System.FormatException)
            {
                pnlErrorMessage.Visible = true;
                errorMessage.Text = "Seems like you are trying to access this page directly. Please use the home page to come back to Order Details.";
            }
        }
    }
    public bool showCCDetails(string paymentMethodName)
    {
        return (paymentMethodName == "CREDIT CARD") ? true : false;
    }
    public bool showCheckDetails(string paymentMethodName)
    {
        return (paymentMethodName == "CHECK") ? true : false;
    }
}