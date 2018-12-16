using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class devotee_manageDevotee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
        }
    }

    protected void cmdEditDevoteeInfo_Click(object sender, EventArgs e)
    {
        //String devoteeId = (String)Request.QueryString["devoteeId"];
        Response.Redirect("~/devotee/editDevotee.aspx?devoteeId=" + (String)Request.QueryString["devoteeId"]);
    }
    protected void cmdCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/");
    }
    protected void duplicate_click(object sender, EventArgs e)
    {
        
    }
    protected void GrdDuplicateManager_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Duplicate")
        {
            DevoteeDuplicateManager.UpdateParameters["didOriginal"].DefaultValue = e.CommandArgument.ToString();
            DevoteeDuplicateManager.UpdateParameters["didNew"].DefaultValue = Request.QueryString["devoteeId"];
            try
            {
                int result = DevoteeDuplicateManager.Update();
                if (result == -1)
                {
                    Response.Redirect("~/devotee/manageDevotee.aspx?devoteeId=" + Request.QueryString["devoteeId"]);
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
    }

}