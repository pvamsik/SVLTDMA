﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Devotee_devoteeServiceHistory : BasePage
{
    public List<ServiceRequestDTO> serviceRequests;
    bool isAjax = false;

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

    protected int Service_Request_ID
    {
        get
        {
            return Utilities.GetInteger(ViewState["Service_Request_ID"]);
        }
        set
        {
            ViewState["Service_Request_ID"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        Devotee_ID = Utilities.GetInteger(Request.QueryString["devoteeid"]);

        Service_Request_ID = Utilities.GetInteger(Request.QueryString["servicerequestid"]);

        serviceRequests = data.GetServiceRequests(Service_Request_ID, Devotee_ID);

        //gvServiceRequestInfo.DataSource = serviceRequests;
        //gvServiceRequestInfo.DataBind();

        //ServiceRequestInfo1.Devotee_ID = Devotee_ID;
        //ServiceRequestInfo1.Service_Request_ID = Service_Request_ID;

    }

    protected void gvServiceRequestInfo_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "REFUND")
        {
            string serviceRequestId = Convert.ToString(e.CommandArgument);

            ServiceRequestTransactionDTO srt = data.GetServiceRequestTransaction(0, serviceRequestId).LastOrDefault();

            paymentProcessor pp = new paymentProcessor("CP");
            paymentResponse res = pp.refundPayment(srt.TransactionID, srt.ApprovedAmount, srt.CardNumber);

            if (res.Approved == true)
            {
            }
            //gvServiceRequestInfo.DataKeys[e.Row.RowIndex].Values[0]
        }
        else if (e.CommandName == "VOID")
        {
            string serviceRequestId = Convert.ToString(e.CommandArgument);

            ServiceRequestTransactionDTO srt = data.GetServiceRequestTransaction(0, serviceRequestId).LastOrDefault();

            paymentProcessor pp = new paymentProcessor("CP");
            paymentResponse res = pp.refundPayment(srt.TransactionID, srt.ApprovedAmount, srt.CardNumber);

            if (res.Approved == true)
            {
            }
            //gvServiceRequestInfo.DataKeys[e.Row.RowIndex].Values[0]
        }
    }
}