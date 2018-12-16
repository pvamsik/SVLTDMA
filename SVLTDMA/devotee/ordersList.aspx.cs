using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CommonDTO;
using CommonDTO.Entities;

public partial class devotee_orderList : BasePage
{
    Order o;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Request.QueryString["devoteeId"]))
            Response.Redirect("~/devotee/searchDevotee.aspx");

        string devoteeId = Request.QueryString["devoteeId"];

        if(!(string.IsNullOrEmpty(devoteeId)))
        {
            int id = Convert.ToInt32(devoteeId);
            using (OrderEntities context = new OrderEntities())
            {
                List<Order> orders = context.Orders.Where(x => x.devoteeID == id).OrderByDescending(x => x.Id).ToList();
                gvOrdersList.DataSource = orders;
                gvOrdersList.DataBind();
            }
        }
    }
    protected void gvOrdersList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string devoteeId = Request.QueryString["devoteeId"];
        int rowIndex = Convert.ToInt32(e.CommandArgument.ToString());
        int orderIdString;
        switch (e.CommandName)
        {
            case "View":
                Response.Redirect(string.Format("~/devotee/orderDetails.aspx?devoteeId={0}&orderId={1}", devoteeId, gvOrdersList.DataKeys[rowIndex].Value.ToString()));
                break;
            case "Email":
                orderIdString = Convert.ToInt32(gvOrdersList.DataKeys[rowIndex].Value);
                using (OrderEntities context = new OrderEntities())
                {
                    Order myOrder = context.Orders.Where(x => x.Id == orderIdString).SingleOrDefault();
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
                break;
            case "Print":
                orderIdString = Convert.ToInt32(gvOrdersList.DataKeys[rowIndex].Value);
                using (OrderEntities context = new OrderEntities())
                {
                    Order myOrder = context.Orders.Where(x => x.Id == orderIdString).SingleOrDefault();
                    ClientDTO client = getClientInfo(Request.UserHostName);

                    if (client.PrinterPort != "")
                    {
                        printManager pM = new printManager(client.PrinterPort, client.PrinterSettings);
                        try
                        {
                            pM.printReceipt(myOrder);
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
                break;
            default:
                break;
        }
    }
}