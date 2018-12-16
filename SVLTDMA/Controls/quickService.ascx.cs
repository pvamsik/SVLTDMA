﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using CommonDTO;
public partial class Controls_quickService : System.Web.UI.UserControl
{
    Data data;
    int Service_Request_ID;
    public int rowIndex;

    #region Properties
    protected int Devotee_ID
    {
        get
        {
            return Utilities.GetInteger(ViewState["DevoteeID"]);
        }
        set
        {
            ViewState["DevoteeID"] = value;
        }
    }
    protected List<ServiceTypeDTO> ServiceTypes
    {
        get
        {
            if (ViewState["ServiceTypes"] == null)
                ViewState["ServiceTypes"] = data.GetServiceTypes().FindAll(s=>s.IsActive == true);

            return (List<ServiceTypeDTO>)ViewState["ServiceTypes"];

        }
    }
    protected List<ServiceDTO> Services
    {
        get
        {
            if (ViewState["Services"] == null)
                ViewState["Services"] = data.GetServices();

            return (List<ServiceDTO>)ViewState["Services"];

        }
    }
    protected List<ServiceDTO> ServiceList
    {
        get
        {
            if (rblLocation.SelectedItem == null)
                return Services.FindAll(s => s.Service_Type_ID == ServiceTypes.FirstOrDefault().Service_Type_ID);
            else
                return Services.FindAll(s => s.Service_Type_ID.ToString() == rblLocation.SelectedItem.Value);
        }

    }
    public List<PaymentTypeDTO> PaymentTypes
    {
        get
        {
            if (ViewState["paymentTypes"] == null)
                ViewState["paymentTypes"] = data.GetPaymentTypes();

            return (List<PaymentTypeDTO>)ViewState["paymentTypes"];
        }
    }
    public List<CreditCardTypeDTO> CreditCardTypes
    {
        get
        {
            if (ViewState["creditCardTypes"] == null)
                ViewState["creditCardTypes"] = data.GetCreditCardTypes();

            return (List<CreditCardTypeDTO>)ViewState["creditCardTypes"];
        }
    }    
    #endregion Properties
    protected void Page_Load(object sender, EventArgs e)
    {
        data = new Data();

        if (!IsPostBack)
        {
            Devotee_ID = Utilities.GetInteger(Request.QueryString["devoteeid"]);

            txtServiceDate.Text = DateTime.Today.ToShortDateString();
            txtCheckDate.Text = DateTime.Today.ToShortDateString();

            rblLocation.DataSource = ServiceTypes;
            rblLocation.DataBind();

            ServiceTypeDTO serviceTypeDto = ServiceTypes.Find(st => st.ShowDefault == true);
            if (serviceTypeDto != null)
                rblLocation.SelectedIndex = rblLocation.Items.IndexOf(rblLocation.Items.FindByValue(serviceTypeDto.Service_Type_ID.ToString()));

            lblSelectedServiceFee.Text = "0.00";
            txtServiceFee.Text = "0.00";

            rowIndex = ServiceList.IndexOf(ServiceList.Find(st => st.ShowDefault == true));
            //lvServices.DataSource = ServiceList;
            //lvServices.DataBind();

            gvServices.DataSource = ServiceList;
            gvServices.DataBind();

            rdlPaymentType.DataSource = PaymentTypes;
            rdlPaymentType.DataBind();
            PaymentTypeDTO paymentTypeDto = PaymentTypes.Find(st => st.ShowDefault == true);
            if (paymentTypeDto != null)
                rdlPaymentType.SelectedIndex = rdlPaymentType.Items.IndexOf(rdlPaymentType.Items.FindByValue(paymentTypeDto.Payment_type_ID.ToString()));
        }
    }    
    protected void rblLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        rowIndex = ServiceList.IndexOf(ServiceList.Find(st => st.ShowDefault == true));

        if (rowIndex < 0)
            rowIndex = ServiceList.IndexOf(ServiceList.FirstOrDefault());

        lblSelectedServiceFee.Text = "0.00";
        txtServiceFee.Text = "0.00";
        //lvServices.DataSource = ServiceList;
        //lvServices.DataBind();
    }    
    protected void lvServices_DataBound(object sender, EventArgs e)
    {
        /*
        if (lvServices.Items.Count > 0)
        {
            if (lvServices.SelectedIndex == -1)
                lvServices.SelectedIndex = 0;

            Label selectedServiceID = (Label)lvServices.Items[lvServices.SelectedIndex].FindControl("lblServiceID");
            lblSelectedService.Text = selectedServiceID.Text;
            Label selectedServiceName = (Label)lvServices.Items[lvServices.SelectedIndex].FindControl("lblServiceName");
            lblSelectedServiceName.Text = selectedServiceName.Text;
            Label selectedServiceFee = (Label)lvServices.Items[lvServices.SelectedIndex].FindControl("lblServiceFee");

            lblSelectedServiceFee.Text = selectedServiceFee.Text;
            txtServiceFee.Text = selectedServiceFee.Text;

            txtServiceFee.Enabled = ServiceList[lvServices.SelectedIndex].PriceEditable;
            //lvServices.DataKeys[lvServices.SelectedIndex][1].
        }
        */
    }
    protected void lvServices_SelectedIndexChanging(object sender, ListViewSelectEventArgs e)
    {
        rowIndex = e.NewSelectedIndex;
    }
    protected void lvServices_SelectedIndexChanged(object sender, EventArgs e)
    {
        /*
        lvServices.DataSource = ServiceList;
        lvServices.DataBind();
        */
    }
    protected void rdlPaymentType_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (rdlPaymentType.SelectedItem.Text)
        {
            case "Cash":
                pnlCard.Visible = false;
                pnlCheck.Visible = false;
                break;
            case "Check":
                pnlCard.Visible = false;
                pnlCheck.Visible = true;
                txtCheckNumber.Focus();
                break;
            case "Credit Card":
                pnlCard.Visible = true;
                pnlCheck.Visible = false;

                rdlCCType.DataSource = CreditCardTypes;
                rdlCCType.DataBind();

                CreditCardTypeDTO creditCardTypeDto = CreditCardTypes.Find(st => st.ShowDefault == true);
                if (creditCardTypeDto != null)
                    rdlCCType.SelectedIndex = rdlCCType.Items.IndexOf(rdlCCType.Items.FindByValue(creditCardTypeDto.Credit_card_type_id.ToString()));

                txtCCSwipe.Focus();
                break;
            default:
                break;
        }
    }
    protected void rdlCCType_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtCCSwipe.Focus();
    }
    protected void txtCCSwipe_TextChanged(object sender, EventArgs e)
    {
        string string1;
        try
        {
            string1 = txtCCSwipe.Text;

            string[] ccparts;
            ccparts = string1.Split('^');

            string ccNumber = ccparts[0].Substring(2);
            string ccName = ccparts[1].Trim();
            string ccExpiration = ccparts[2].Substring(0, 4);

            txtCardHolderName.Text = ccName;
            txtCardNumber.Text = ccNumber;
            txtCardExpDate.Text = ccExpiration;
            ddlCCExpYear.SelectedValue = ccExpiration.Substring(0, 2);
            ddlCCExpMonth.SelectedValue = ccExpiration.Substring(2, 2);
            txtCCSwipe.Text = "";
            txtCardCVVNumber.Focus();
            lblCCReader.Visible = false;
        }
        catch (Exception)
        {
            txtCCSwipe.Text = "";
            txtCCSwipe.Focus();
            txtCardHolderName.Text = "";
            txtCardNumber.Text = "";
            txtCardExpDate.Text = "";
            ddlCCExpYear.SelectedIndex = 0;
            ddlCCExpMonth.SelectedIndex = 0;

            lblCCReader.Visible = true;
            lblCCReader.Text = "Unable to read Credit Card";
        }
    }
    protected void chkValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if ((rdlPaymentType.SelectedValue == "1") & (txtCheckNumber.Text == ""))
        {
            args.IsValid = false;
        }
    }
    protected void chkDateValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if ((rdlPaymentType.SelectedValue == "1") & (txtCheckDate.Text == ""))
        {
            args.IsValid = false;
        }
    }
    protected void cvCCTypeValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if ((rdlPaymentType.SelectedItem.Text == "Credit Card") & (rdlCCType.SelectedItem == null))
        {
            args.IsValid = false;
        }
    }
    protected void cvCardHolderName_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if ((rdlPaymentType.SelectedItem.Text == "Credit Card") & (txtCardHolderName.Text == ""))
        {
            args.IsValid = false;
        }
    }
    protected void cvCVVValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if ((rdlPaymentType.SelectedItem.Text == "Credit Card") & (txtCardCVVNumber.Text == ""))
        {
            args.IsValid = false;
        }
    }
    protected void cvCardNumber_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if ((rdlPaymentType.SelectedItem.Text == "Credit Card") & (txtCardNumber.Text == ""))
        {
            args.IsValid = false;
        }
    }
    protected void feeValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //double suggestedFee = Convert.ToDouble(lblSelectedServiceFee.Text);
        //double submittedFee = Convert.ToDouble(txtServiceFee.Text);
        //int result = suggestedFee.CompareTo(submittedFee);
        //if (result > 0)
        //{
        //    args.IsValid = false;
        //}

        if (string.IsNullOrEmpty(txtServiceFee.Text))
            args.IsValid = false;
        else
        {
            double submittedFee = Convert.ToDouble(txtServiceFee.Text);
            if(submittedFee <= 0)
                args.IsValid = false;
        }
    }
    protected bool Validate()
    {
        bool isValid = true;

        if (!chkValidator.IsValid)
            isValid = false;

        if (!chkDateValidator.IsValid)
            isValid = false;

        if (!cvCCTypeValidator.IsValid)
            isValid = false;

        if (!cvCardHolderName.IsValid)
            isValid = false;

        if (!cvCardNumber.IsValid)
            isValid = false;

        if (!cvCVVValidator.IsValid)
            isValid = false;

        if (!rfvServiceFee.IsValid)
            isValid = false;

        if (!feeValidator.IsValid)
            isValid = false;
        
        return isValid;
    }
    protected void btnAddService_Click(object sender, EventArgs e)
    {
        if (Validate())
        {

            string devoteeId;
            devoteeId = Request.QueryString["devoteeId"];
            devoteeInfo di;
            if (devoteeId != null)
            {
                //Populate the Devotee Info
                di = new devoteeInfo(devoteeId);
            }
            else
            {
                di = new devoteeInfo();
                di.lastName = "Undefined";
            }

            string serviceName = lblSelectedServiceName.Text;
            decimal amount = Convert.ToDecimal(txtServiceFee.Text);
            bool IsServiceRequested = false;
            switch (rdlPaymentType.SelectedValue)
            {
                case "1":
                    AddNewRequest();
                    IsServiceRequested = ProcessCheckPayment(di, serviceName, amount);
                    break;
                case "2":
                    AddNewRequest();
                    IsServiceRequested = ProcessCashPayment(di, serviceName, amount);
                    break;
                case "3":
                    //AddNewRequest();
                    IsServiceRequested = ProcessCreditCardPayment(di, serviceName, amount);
                    break;
                default:
                    break;
            }

            ServiceRequestDTO serviceRequest = data.GetServiceRequests(Service_Request_ID, 0).FirstOrDefault();
            printManager pM = new printManager();
            if (pM.testPrinterStatus() == true)
            {
                DevoteeDTO Devotee = new DevoteeDTO();
                Devotee.Devotee_First_Name = di.firstName;
                Devotee.Devotee_Last_Name = di.lastName;
                pM.printReceipt(Devotee, serviceRequest, null, "PrintReceipt");
            }
            else
            {
                lblPrinterMsg.Text = "Printer Offline !!!";
                lblPrinterMsg.Visible = true;
            }

            if (IsServiceRequested)
                Response.Redirect("ServiceRequestDetails.aspx?servicerequestid=" + Service_Request_ID, false);
        }
    }
    public void AddNewRequest()
    {
        //Finally store the information to the database
        ServiceRequestDTO devoteeServiceDTO = new ServiceRequestDTO();
        devoteeServiceDTO.Devotee_ID = Devotee_ID;
        devoteeServiceDTO.Service_ID = Convert.ToInt32(lblSelectedService.Text);
        devoteeServiceDTO.Service_Date = txtServiceDate.Text;
        devoteeServiceDTO.Service_Fee_Paid = txtServiceFee.Text;
        devoteeServiceDTO.Payment_Type_id = int.Parse(rdlPaymentType.SelectedItem.Value);
        devoteeServiceDTO.Check_Number = txtCheckNumber.Text;
        devoteeServiceDTO.Check_Date = txtCheckDate.Text;
        devoteeServiceDTO.Comment1 = txtComment1.Text;
        devoteeServiceDTO.Comment2 = txtComment2.Text;
        devoteeServiceDTO.Comment3 = txtComment3.Text;
        devoteeServiceDTO.Created_Date = Convert.ToString(DateTime.Now);
        Service_Request_ID = data.AddServiceRequest(devoteeServiceDTO);
    }
    private bool ProcessCheckPayment(devoteeInfo di, string serviceName, decimal amount)
    {

        if ((di.email != "") && (di.email != null))
        {
            //Populate the Email body based on email template and send email
            string body = PopulateBody(di.firstName, serviceName, string.Format("{0:c}", amount));

            EmailProvider ep = new EmailProvider();
            List<string> receivers = new List<string>();
            receivers.Add("receipts@svlotustemple.org");
            string sendEmailResultStatus = ep.sendEmail("Thank You for your Order", body, di.email, receivers);

            if (sendEmailResultStatus != "Success")
            {
                LogEntry logEntry = new LogEntry();
                logEntry.EventId = 100;
                logEntry.Priority = 2;
                logEntry.Message = "Failed to send email due to the followwing reason: " + sendEmailResultStatus;
                Logger.Write(logEntry);
            }
        }

        ////Check if printer is Online
        //printManager pM = new printManager();
        //if (pM.testPrinterStatus() == true)
        //{
        //    pM.printCheckReceipt(serviceName, amount.ToString(), di, txtCheckNumber.Text);
        //    lblPrinterMsg.Visible = false;
        //}
        //else
        //{
        //    lblPrinterMsg.Text = "Printer Offline!!!";
        //    lblPrinterMsg.Visible = true;
        //}

        return true;
    }   
    private bool ProcessCashPayment(devoteeInfo di, string serviceName, decimal amount)
    {

        if ((di.email != "") && (di.email != null))
        {
            //Populate the Email body based on email template and send email
            string body = PopulateBody(di.firstName, serviceName, string.Format("{0:c}", amount));

            EmailProvider ep = new EmailProvider();
            List<string> receivers = new List<string>();
            receivers.Add("receipts@svlotustemple.org");
            string sendEmailResultStatus = ep.sendEmail("Thank You for your Order", body, di.email, receivers);

            if (sendEmailResultStatus != "Success")
            {
                LogEntry logEntry = new LogEntry();
                logEntry.EventId = 100;
                logEntry.Priority = 2;
                logEntry.Message = "Failed to send email due to the followwing reason: " + sendEmailResultStatus;
                Logger.Write(logEntry);
            }
        }

        ////Check if printer is Online
        //printManager pM = new printManager();
        //if (pM.testPrinterStatus() == true)
        //{
        //    pM.printCashReceipt(serviceName, amount.ToString(), di);
        //    lblPrinterMsg.Visible = false;
        //}
        //else
        //{
        //    lblPrinterMsg.Text = "Printer Offline!!!";
        //    lblPrinterMsg.Visible = true;
        //}

        return true;
    }
    private bool ProcessCreditCardPayment(devoteeInfo di, string serviceName, decimal amount)
    {
        bool flag = false;
        string expirationMonth, expirationYear;

        expirationMonth = ddlCCExpMonth.SelectedValue; //txtCardExpDate.Text.Substring(2, 2);
        expirationYear = ddlCCExpYear.SelectedValue; //txtCardExpDate.Text.Substring(0, 2);

        //Try sending the payment request to Authorize.Net
        paymentProcessor pp = new paymentProcessor(ConfigurationManager.AppSettings["AuthorizeNetTransactionType"]);
        paymentResponse res = pp.processPaymentWithoutCard(txtCardNumber.Text, String.Concat(expirationMonth, expirationYear), amount, serviceName, di);


        if (res.Approved == true)
        {
            flag = true;

            AddNewRequest();

            string ccExpiration = expirationYear + expirationMonth;
            string ccType = rdlCCType.SelectedValue;
            int Service_Req_Tran_ID = data.AddEditServiceRequestTransaction(Service_Request_ID, 0, "Purchase", res, ccType, ccExpiration);

            if ((di.email != "") && (di.email != null))
            {
                //Populate the Email body based on email template and send email
                string body = PopulateBody(di.firstName, serviceName, string.Format("{0:c}", amount));

                EmailProvider ep = new EmailProvider();
                List<string> receivers = new List<string>();
                receivers.Add("receipts@svlotustemple.org");
                string sendEmailResultStatus = ep.sendEmail("Thank You for your Order", body, di.email, receivers);

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
        else
        {
            flag = false;
            data.DeleteServiceRequest(Service_Request_ID);
            Service_Request_ID = 0;
            lblAuthorizationError.Text = res.Message;
            lblAuthorizationError.Visible = true;
        }



        /*
        if (res.Approved == true)
        {
            flag = true;
            string ccExpiration = expirationYear + expirationMonth;
            string ccType = rdlCCType.SelectedValue;
            int Service_Req_Tran_ID = data.AddEditServiceRequestTransaction(Service_Request_ID, 0, "Purchase", res, ccType, ccExpiration);

            if ((di.email != "") && (di.email != null))
            {
                //Populate the Email body based on email template and send email
                string body = PopulateBody(di.firstName, serviceName, string.Format("{0:c}", amount));

                EmailProvider ep = new EmailProvider();
                List<string> receivers = new List<string>();
                receivers.Add("receipts@svlotustemple.org");
                string sendEmailResultStatus = ep.sendEmail("Thank You for your Order", body, di.email, receivers);

                if (sendEmailResultStatus != "Success")
                {
                    LogEntry logEntry = new LogEntry();
                    logEntry.EventId = 100;
                    logEntry.Priority = 2;
                    logEntry.Message = "Failed to send email due to the followwing reason: " + sendEmailResultStatus;
                    Logger.Write(logEntry);
                }
            }

            //Check if printer is Online and print the receipt if Printer is Online
            printManager pM = new printManager();
            if (pM.testPrinterStatus() == true)
            {
                pM.printCCReceipt(serviceName, amount.ToString(), res, rdlCCType.SelectedItem.ToString(), "Purchase", expirationMonth, expirationYear, di);
                lblPrinterMsg.Visible = false;
            }
            else
            {
                lblPrinterMsg.Text = "Printer Offline!!!";
                lblPrinterMsg.Visible = true;
            }

            //Hide message for authorization error
            lblAuthorizationError.Visible = false;
        }
        else
        {
            flag = false;
            data.DeleteServiceRequest(Service_Request_ID);
            Service_Request_ID = 0;
            lblAuthorizationError.Text = res.Message;
            lblAuthorizationError.Visible = true;
        }

        if (res.AVSResponse == "No Match on Address (Street) or ZIP" || res.AVSResponse == "Five digit ZIP matches, Address (Street) does not")
        {
            System.Windows.Forms.MessageBox.Show("Please confirm address with Devotee!!!", "Address Mismatch", System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Exclamation);
        }

        */

        return flag;
    }
    private string PopulateBody(string userName, string serviceName, string serviceAmount)
    {
        string body = string.Empty;
        using (StreamReader reader = new StreamReader(Server.MapPath("~/assets/emailReceiptTemplate.html")))
        {
            body = reader.ReadToEnd();
        }
        body = body.Replace("{UserName}", userName);
        body = body.Replace("{ServiceName}", serviceName);
        body = body.Replace("{ServiceAmount}", serviceAmount);
        return body;
    }
    protected void gvServices_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {

    }
    protected void gvServices_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void gvServices_DataBound(object sender, EventArgs e)
    {

    }
}