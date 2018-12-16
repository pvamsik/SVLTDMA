using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Text;
using System.Web.UI.WebControls;

public partial class devotee_serviceRequestDetails : BasePage
{
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

    protected List<ServiceRequestDTO> ServiceRequests
    {
        get
        {
            if (ViewState["serviceRequests"] != null)
                return (List<ServiceRequestDTO>)ViewState["serviceRequests"];
            else
                return new List<ServiceRequestDTO>();
        }
        set
        {
            ViewState["serviceRequests"] = value;
        }
    }

    protected DevoteeDTO Devotee
    {
        get
        {
            if (ViewState["Devotee"] != null)
                return (DevoteeDTO)ViewState["Devotee"];
            else
                return new DevoteeDTO();
        }
        set
        {
            ViewState["Devotee"] = value;
        }
    }

    bool isAjax = false;
    bool isPrint = false;
    string serviceId;

    protected void Page_Load(object sender, EventArgs e)
    {
        isAjax = Utilities.GetBoolean(Request.QueryString["ajax"]);

        isPrint = Utilities.GetBoolean(Request.QueryString["print"]);

        if (!isAjax)
        {
            Devotee_ID = Utilities.GetInteger(Request.QueryString["devoteeid"]);

            Service_Request_ID = Utilities.GetInteger(Request.QueryString["servicerequestid"]);

            ServiceRequests = data.GetServiceRequests(Service_Request_ID, Devotee_ID);

            Devotee = data.GetDevotee(Devotee_ID);
        }
        
        //ServiceRequestInfo1.Devotee_ID = Devotee_ID;
        //ServiceRequestInfo1.Service_Request_ID = Service_Request_ID;
        //ServiceRequestInfo1.IsAjax = isAjax;
        //ServiceRequestInfo1.IsPrint = isPrint;
        //ServiceRequestInfo1.Devotee = Devotee;
        //ServiceRequestInfo1.ServiceRequests = ServiceRequests;

        //if (isPrint)
        //{
        //    StringBuilder sb = new StringBuilder();
        //    StringWriter sw = new StringWriter(sb);
        //    HtmlTextWriter hw = new HtmlTextWriter(sw);
        //    ServiceRequestInfo1.RenderControl(hw);
        //    Response.Write(sb.ToString());
        //    Response.End();
        //}

        //isAjax = Utilities.GetBoolean(Request.QueryString["ajax"]);

        //if (!isAjax)
        //{
        //    Devotee_ID = Utilities.GetInteger(Request.QueryString["devoteeid"]);

        //    Service_Request_ID = Utilities.GetInteger(Request.QueryString["servicerequestid"]);

        //    ServiceRequestInfo1.Devotee_ID = Devotee_ID;
        //    ServiceRequestInfo1.Service_Request_ID = Service_Request_ID;
        //}
        //else
        //{
        //    //Check if printer is Online
        //    printManager pM = new printManager();
        //    if (pM.testPrinterStatus() == true)
        //    {
        //        ServiceRequestDTO serviceRequests = data.GetServiceRequests(Service_Request_ID, 0).FirstOrDefault();

        //        //pM.printCCReceipt(

        //        Response.End();
        //        //pM.printCheckReceipt(serviceName, amount.ToString(), di, txtCheckNumber.Text);
        //        //lblPrinterMsg.Visible = false;
        //    }
        //    else
        //    {
        //        Response.Write("Printer Offline!!!");
        //        Response.End();
        //    }
        //}
    }
}