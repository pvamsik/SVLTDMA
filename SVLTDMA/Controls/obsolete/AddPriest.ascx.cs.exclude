using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Profile;

public partial class Controls_AddPriest : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void cmdAddPriest_Click(object sender, EventArgs e)
    {
        sqlDSPriestsData.InsertParameters["firstName"].DefaultValue = txtPriestFirstName.Text;
        sqlDSPriestsData.InsertParameters["lastName"].DefaultValue = txtPriestLastName.Text;
        sqlDSPriestsData.InsertParameters["createDate"].DefaultValue = DateTime.Now.ToString();
        sqlDSPriestsData.InsertParameters["createdBy"].DefaultValue = Page.User.Identity.Name.ToLower();
        sqlDSPriestsData.InsertParameters["modifyDate"].DefaultValue = DateTime.Now.ToString();
        sqlDSPriestsData.InsertParameters["modifiedBy"].DefaultValue = HttpContext.Current.User.Identity.Name.ToString();

        try
        {
            sqlDSPriestsData.Insert();
            lblmsg.Text = "Priest created successfully!!!";
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
            throw;
        }
        finally
        {
            Response.Redirect("~/manage/PriestManager.aspx");
        }
    }
}