using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using CommonDTO;

public partial class Controls_serviceInfo : System.Web.UI.UserControl
{
    Data data;
    int Service_Request_ID;
    protected ServiceRequestDTO serviceRequest;
    protected void Page_Load(object sender, EventArgs e)
    {
        data = new Data();
        lblMessage.Visible = false;

        //bool isAjax = Utilities.GetBoolean(Request.QueryString["ajax"]);
        Service_Request_ID = Utilities.GetInteger(Request.QueryString["servicerequestid"]);

        serviceRequest = data.GetServiceRequests(Service_Request_ID, 0).FirstOrDefault();

        DateTime myDate = Convert.ToDateTime(serviceRequest.Check_Date);
        serviceRequest.Check_Date = myDate.ToShortDateString();

        myDate = Convert.ToDateTime(serviceRequest.Service_Date);
        serviceRequest.Service_Date = myDate.ToShortDateString();


        gvRequestTransactions.DataSource = serviceRequest.Transactions;
        gvRequestTransactions.DataBind();

    }

    protected void Print_Click(object sender, EventArgs e)
    {

        List<ClientDTO> clients;
        if (Application["clients"] != null)
        {
            clients = Application["clients"] as List<ClientDTO>;
        }
        else
        {
            clients = data.GetClients();
        }
        if (clients != null)
        {
            string ipAddress = Request.UserHostName;
            ClientDTO client = clients.Where(x => x.ClientIP == ipAddress).SingleOrDefault();

            string printerPort = client.PrinterPort;
            string printerSettings = client.PrinterSettings;
            if (string.IsNullOrEmpty(printerSettings))
                printerSettings = "";

            printManager pM = new printManager(printerPort, printerSettings);
            if (pM.testPrinterStatus() == true)
            {
                DevoteeDTO Devotee = data.GetDevotee(serviceRequest.Devotee_ID);
                serviceRequest = data.GetServiceRequests(Service_Request_ID, 0).FirstOrDefault();

                if (sender == TempleReceipt)
                {
                    pM.printReceipt(Devotee, serviceRequest, null, "TempleCopy");
                }
                if (sender == MerchantReceipt)
                {
                    pM.printReceipt(Devotee, serviceRequest, null, "MerchantCopy");
                }
                if (sender == CustomerReceipt)
                {
                    pM.printReceipt(Devotee, serviceRequest, null, "CustomerCopy");
                }
                if (sender == PrintReceipt)
                {
                    pM.printReceipt(Devotee, serviceRequest, null, "PrintReceipt");
                }
                //pM.printReceipt(Devotee, serviceRequest, null);
            }
            else
            {
                lblMessage.Text = "Printer Offline !!!";
                lblMessage.Visible = true;
            }
        }
    }


    protected void gvRequestTransactions_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DateTime dt = Convert.ToDateTime(e.Row.Cells[4].Text);

            bool canVoid = false;
            bool canRefund = false;

            if (dt.Date.ToShortDateString() == DateTime.Today.Date.ToShortDateString())
                canVoid = (dt.Date <= DateTime.Today.AddHours(10).AddMinutes(30).AddSeconds(0));
            else
                canRefund = (dt.Date.AddDays(10) >= DateTime.Now);
            //if (canVoid)
            //    e.Row.Cells[5].Text = "<a href=\"\" class=\"\">Void</>";
            //else if (canRefund)
            //    e.Row.Cells[5].Text = "<a href=\"\" class=\"\">Refund</>";
            //else
            //e.Row.Cells[6].Text = "";
        }

    }
    protected void lnkDevInfo_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/devotee/manageDevotee.aspx?devoteeID=" + serviceRequest.Devotee_ID);
    }

    protected void BtnVoidTransaction_Click(object sender, EventArgs e)
    {
        Service_Request_ID = Utilities.GetInteger(Request.QueryString["servicerequestid"]);
        int res;
        devoteeInfo di = new devoteeInfo(Convert.ToString(serviceRequest.Devotee_ID));
        Boolean success = false;
        printManager pM = new printManager();
        switch (serviceRequest.Payment_type_description)
        {
            case "Cash":
                res = data.VoidServiceRequest(Service_Request_ID);
                success = true;

                //Check if printer is Online

                if (pM.testPrinterStatus() == true)
                {
                    pM.printCashReceipt(serviceRequest.Service_Name, serviceRequest.Service_Fee_Paid, di);
                    lblPrinterMsg.Visible = false;
                }
                else
                {
                    lblPrinterMsg.Text = "Printer Offline!!!";
                    lblPrinterMsg.Visible = true;
                }
                break;
            case "Check":
                res = data.VoidServiceRequest(Service_Request_ID);
                success = true;

                //Check if printer is Online
                if (pM.testPrinterStatus() == true)
                {
                    pM.printCheckReceipt(serviceRequest.Service_Name, serviceRequest.Service_Fee_Paid, di, serviceRequest.Check_Number);
                    lblPrinterMsg.Visible = false;
                }
                else
                {
                    lblPrinterMsg.Text = "Printer Offline!!!";
                    lblPrinterMsg.Visible = true;
                }

                break;
            case "Credit Card":
                paymentProcessor pp = new paymentProcessor(ConfigurationManager.AppSettings["AuthorizeNetTransactionType"]);
                string transactionId = serviceRequest.Transactions[0].TransactionID;
                paymentResponse pRes = pp.voidTransaction(transactionId);
                if (pRes.Approved == true)
                {
                    res = data.AddEditServiceRequestTransaction(Service_Request_ID, 0, "Refund", pRes, "", "");
                    res = data.VoidServiceRequest(Service_Request_ID);
                    success = true;

                    //Check if printer is Online and print the receipt if Printer is Online
                    if (pM.testPrinterStatus() == true)
                    {
                        string expirationYear = (serviceRequest.Transactions[0].CardExpiration).Substring(0, 2);
                        string expirationMonth = (serviceRequest.Transactions[0].CardExpiration).Substring(2, 2);
                        string cardType = serviceRequest.Transactions[0].CardType;
                        pM.printCCReceipt(serviceRequest.Service_Name, serviceRequest.Service_Fee_Paid, pRes, cardType, "Refund", expirationMonth, expirationYear, di);
                        lblPrinterMsg.Visible = false;
                    }
                    else
                    {
                        lblPrinterMsg.Text = "Printer Offline!!!";
                        lblPrinterMsg.Visible = true;
                    }

                }
                if (success == true)
                {
                    if (di.email != "")
                    {
                        //Populate the Email body based on email template and send email
                        string body = PopulateBody(di.firstName, serviceRequest.Service_Name, serviceRequest.Service_Fee_Paid);

                        EmailProvider ep = new EmailProvider();
                        List<string> receivers = new List<string>();
                        receivers.Add("receipts@svlotustemple.org");
                        string sendEmailResultStatus = ep.sendEmail("Refund Confirmation", body, di.email, receivers);

                        if (sendEmailResultStatus != "Success")
                        {
                            LogEntry logEntry = new LogEntry();
                            logEntry.EventId = 100;
                            logEntry.Priority = 2;
                            logEntry.Message = "Failed to send email due to the followwing reason: " + sendEmailResultStatus;
                            Logger.Write(logEntry);
                        }
                    }
                }
                break;
        }

        Response.Redirect(Request.UrlReferrer.OriginalString);
        /*"~/devotee/manageDevotee.aspx?devoteeID=" + serviceRequest.Devotee_ID*/
    }

    private string PopulateBody(string userName, string serviceName, string serviceAmount)
    {
        string body = string.Empty;
        using (StreamReader reader = new StreamReader(Server.MapPath("~/assets/emailRefundTemplate.html")))
        {
            body = reader.ReadToEnd();
        }
        body = body.Replace("{UserName}", userName);
        body = body.Replace("{ServiceName}", serviceName);
        body = body.Replace("{ServiceAmount}", serviceAmount);
        return body;
    }


    protected void EmailReceipt_Click(object sender, EventArgs e)
    {
        devoteeInfo di = new devoteeInfo(Convert.ToString(serviceRequest.Devotee_ID));
        if ((di.email != "") && (di.email != null))
        {
            //Populate the Email body based on email template and send email
            string body = PopulateBody(di.firstName, serviceRequest.Service_Name, string.Format("{0:c}", serviceRequest.Service_Fee_Paid));

            EmailProvider ep = new EmailProvider();
            List<string> receivers = new List<string>();
            receivers.Add("receipts@svlotustemple.org");
            string sendEmailResultStatus = ep.sendEmailReceipt("Thank You for your Order", body, di.email);

            if (sendEmailResultStatus != "Success")
            {
                LogEntry logEntry = new LogEntry();
                logEntry.EventId = 100;
                logEntry.Priority = 2;
                logEntry.Message = "Failed to send email due to the followwing reason: " + sendEmailResultStatus;
                Logger.Write(logEntry);
            }
        }
    }
}