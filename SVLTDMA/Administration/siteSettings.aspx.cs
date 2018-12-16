using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net.Configuration;

public partial class Administration_siteSettings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack == true))
        {
            txtSiteTitle.Text = ConfigurationManager.AppSettings["institutionName"].ToString();
            txtSiteAddress.Text = ConfigurationManager.AppSettings["institutionAddress"].ToString();
            txtSiteIcon.Text = ConfigurationManager.AppSettings["institutionLogo"].ToString();
            chkEnvironment.Checked = Convert.ToBoolean(ConfigurationManager.AppSettings["prodEnvironment"]);
        }
    }

    protected void cmdUpdtSiteSettings_Click(object sender, EventArgs e)
    {
        ConfigurationManager.AppSettings["institutionName"] = txtSiteTitle.Text;
        ConfigurationManager.AppSettings["institutionAddress"] = txtSiteAddress.Text;
        ConfigurationManager.AppSettings["institutionLogo"] = txtSiteIcon.Text;
        ConfigurationManager.AppSettings["prodEnvironment"] = chkEnvironment.Checked.ToString();
        Response.Redirect("~/Administration/siteSettings.aspx");
    }
}