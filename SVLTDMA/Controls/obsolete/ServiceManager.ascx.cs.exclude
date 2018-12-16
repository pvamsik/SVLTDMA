using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Controls_ServiceManager : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        SqlDataSource1.DeleteParameters["serviceId"].DefaultValue = e.Keys["Service_ID"].ToString();
        SqlDataSource1.Delete();
    }
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        SqlDataSource1.UpdateParameters["serviceId"].DefaultValue = e.Keys["Service_ID"].ToString();

        if (e.NewValues[0].ToString() != null)
        {
            SqlDataSource1.UpdateParameters["serviceName"].DefaultValue = e.NewValues[0].ToString();
        }
        else
        {
            SqlDataSource1.UpdateParameters["serviceName"].DefaultValue = "N/A";
        }
        if (e.NewValues[1].ToString() != null)
        {
            SqlDataSource1.UpdateParameters["serviceDescription"].DefaultValue = e.NewValues[1].ToString();
        }
        else
        {
            SqlDataSource1.UpdateParameters["serviceDescription"].DefaultValue = "N/A";
        }

        if (e.NewValues[2].ToString() != null)
        {
            SqlDataSource1.UpdateParameters["serviceFee"].DefaultValue = e.NewValues[2].ToString().Replace("$", "").Trim();
        }
        else
        {
            SqlDataSource1.UpdateParameters["serviceFee"].DefaultValue = "0.00";
        }        
        SqlDataSource1.Update();
    }

}