using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using CommonDTO;

public partial class Controls_ManageServices : System.Web.UI.UserControl
{
    Data data;
    protected List<ServiceTypeDTO> ServiceTypes
    {
        get
        {
            if (ViewState["ServiceTypes"] == null)
                ViewState["ServiceTypes"] = data.GetServiceTypes().FindAll(s => s.IsActive == true);

            return (List<ServiceTypeDTO>)ViewState["ServiceTypes"];

        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        data = new Data();

        if (!IsPostBack)
        {
            ddlLocation.DataSource = ServiceTypes;
            ddlLocation.DataBind();

            ServiceTypeDTO serviceTypeDto = ServiceTypes.Find(st => st.ShowDefault == true);
            if (serviceTypeDto != null)
                ddlLocation.SelectedIndex = ddlLocation.Items.IndexOf(ddlLocation.Items.FindByValue(serviceTypeDto.Service_Type_ID.ToString()));

        }
    }

    protected void gvServiceManager_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        SDS_ServiceManager.UpdateParameters["serviceId"].DefaultValue = e.Keys["Service_ID"].ToString();

        if (e.NewValues[0].ToString() != null)
        {
            SDS_ServiceManager.UpdateParameters["serviceName"].DefaultValue = e.NewValues[0].ToString();
        }
        else
        {
            SDS_ServiceManager.UpdateParameters["serviceName"].DefaultValue = "N/A";
        }
        if (e.NewValues[1].ToString() != null)
        {
            SDS_ServiceManager.UpdateParameters["serviceDescription"].DefaultValue = e.NewValues[1].ToString();
        }
        else
        {
            SDS_ServiceManager.UpdateParameters["serviceDescription"].DefaultValue = "N/A";
        }

        if (e.NewValues[2].ToString() != null)
        {
            SDS_ServiceManager.UpdateParameters["serviceFee"].DefaultValue = e.NewValues[2].ToString().Replace("$", "").Trim();
        }
        else
        {
            SDS_ServiceManager.UpdateParameters["serviceFee"].DefaultValue = "0.00";
        }

        //SDS_ServiceManager.UpdateParameters["serviceFee"].DefaultValue = e.NewValues[3].ToString();

        //SDS_ServiceManager.UpdateParameters["priceEditable"].DefaultValue = Convert.ToInt32(e.NewValues[4]).ToString();

        //SDS_ServiceManager.UpdateParameters["isActive"].DefaultValue = e.NewValues[5].ToString();

        SDS_ServiceManager.UpdateParameters.Add("showDefault", Convert.ToInt32(e.NewValues[3]).ToString());

        SDS_ServiceManager.UpdateParameters.Add("priceEditable", Convert.ToInt32(e.NewValues[4]).ToString());

        SDS_ServiceManager.UpdateParameters.Add("isActive", Convert.ToInt32(e.NewValues[5]).ToString());

        try
        {
            int res = SDS_ServiceManager.Update();
        }
        catch (Exception ex)
        {
            messages.Text = ex.Message;
        }
    }

    protected void gvServiceManager_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        Response.Redirect(Request.UrlReferrer.ToString());
    }

    protected void gvServiceManager_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        SDS_ServiceManager.DeleteParameters["serviceId"].DefaultValue = e.Keys["Service_ID"].ToString();
        try
        {
            int result = SDS_ServiceManager.Delete();
        }
        catch (Exception ex)
        {
            messages.Text = ex.Message;
        }
    }

    protected void gvServiceManager_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        Response.Redirect(Request.UrlReferrer.ToString());
    }
}