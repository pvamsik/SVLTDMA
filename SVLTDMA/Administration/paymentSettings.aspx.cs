using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Administration_paymentSettings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack == true))
        {
            txtAuthorizeNetCPLogin.Text = ConfigurationManager.AppSettings["AuthorizeNetCPLogin"].ToString();
            txtAuthorizeNetCPTransactionKey.Text = ConfigurationManager.AppSettings["AuthorizeNetCPTransactionKey"].ToString();
            txtAuthorizeNetCNPLogin.Text = ConfigurationManager.AppSettings["AuthorizeNetCNPLogin"].ToString();
            txtAuthorizeNetCNPTransactionKey.Text = ConfigurationManager.AppSettings["AuthorizeNetCNPTransactionKey"].ToString();
            cbAuthorizeNetIsTest.Checked = Convert.ToBoolean(ConfigurationManager.AppSettings["AuthorizeNetTestMode"]);
        }
    }

    protected void cmdUpdtPaymentSettings_Click(object sender, EventArgs e)
    {
        ConfigurationManager.AppSettings["AuthorizeNetCPLogin"] = txtAuthorizeNetCPLogin.Text;
        ConfigurationManager.AppSettings["AuthorizeNetCPTransactionKey"] = txtAuthorizeNetCPTransactionKey.Text;
        ConfigurationManager.AppSettings["AuthorizeNetCNPLogin"] = txtAuthorizeNetCNPLogin.Text;
        ConfigurationManager.AppSettings["AuthorizeNetCNPTransactionKey"] = txtAuthorizeNetCNPTransactionKey.Text;
        ConfigurationManager.AppSettings["AuthorizeNetTestMode"] = Convert.ToString(cbAuthorizeNetIsTest.Checked);
        Response.Redirect("~/Administration/paymentSettings.aspx");
    }
}