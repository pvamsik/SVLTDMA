using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Controls_PriestManager : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        SqlDataSource1.DeleteParameters["priestID"].DefaultValue = e.Keys["Priest_ID"].ToString();
        SqlDataSource1.Delete();
    }
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        SqlDataSource1.DeleteParameters["priestID"].DefaultValue = e.Keys["Priest_ID"].ToString();

        if (e.NewValues[0].ToString() != null)
        {
            SqlDataSource1.UpdateParameters["priestFName"].DefaultValue = e.NewValues[0].ToString();
        }
        else
        {
            SqlDataSource1.UpdateParameters["priestFName"].DefaultValue = "N/A";
        }

        if (e.NewValues[1].ToString() != null)
        {
            SqlDataSource1.UpdateParameters["priestLName"].DefaultValue = e.NewValues[1].ToString();
        }
        else
        {
            SqlDataSource1.UpdateParameters["priestLName"].DefaultValue = "N/A";
        }

        //SqlDataSource1.UpdateParameters["priestActive"].DefaultValue = e.NewValues[2].ToString();
        SqlDataSource1.UpdateParameters["priestLastModifiedDt"].DefaultValue = DateTime.Now.ToString("mm/dd/yyyy hh:mm");
        SqlDataSource1.UpdateParameters["priestLastModifiedBy"].DefaultValue = HttpContext.Current.User.Identity.Name.ToString();

        SqlDataSource1.Update();
    }
}