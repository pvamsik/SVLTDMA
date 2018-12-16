using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net.Configuration;
using System.IO;

public partial class Administration_mailSettings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack == true))
        {
            txtSMTPServer.Text = ConfigurationManager.AppSettings["emailServer"];
            txtSMTPPort.Text = ConfigurationManager.AppSettings["emailServerPort"];
            txtEmailFrm.Text = ConfigurationManager.AppSettings["emailFrom"];
            txtSecurityId.Text = ConfigurationManager.AppSettings["emailUserId"];
            txtSecurityPwd.Text = ConfigurationManager.AppSettings["emailUserPwd"];
            if (Convert.ToBoolean(ConfigurationManager.AppSettings["emailServerSSLEnabled"]) == true)
            {
                rblAuthReqd.SelectedIndex = 0;
            }
            else
            {
                rblAuthReqd.SelectedIndex = 1;
            }
            if (Convert.ToBoolean(ConfigurationManager.AppSettings["emailSend"]) == true)
            {
                rblSendEmails.SelectedIndex = 0;
            }
            else
            {
                rblSendEmails.SelectedIndex = 1;
            }
        }
    }

    protected void cmdUpdtMailSettings_Click(object sender, EventArgs e)
    {
        ConfigurationManager.AppSettings["emailServer"] = txtSMTPServer.Text;
        ConfigurationManager.AppSettings["emailServerPort"] = txtSMTPPort.Text;
        ConfigurationManager.AppSettings["emailFrom"] = txtEmailFrm.Text;
        ConfigurationManager.AppSettings["emailUserId"] = txtSecurityId.Text;
        ConfigurationManager.AppSettings["emailUserPwd"] = txtSecurityPwd.Text;
        ConfigurationManager.AppSettings["emailServerSSLEnabled"] = rblAuthReqd.SelectedValue;
        ConfigurationManager.AppSettings["emailSend"] = rblSendEmails.SelectedValue;
    }

    protected void cmdSendTestEmail_Click(object sender, EventArgs e)
    {
        string body = PopulateBody("Devotee", "Test Service", string.Format("{0:C}", "100.00"));
        EmailProvider ep = new EmailProvider();
        
        List<string> receivers = new List<string>();
        string res = ep.sendEmail("Thank You for your Order", body, "receipts@svlotustemple.org", receivers);

        if (res == "Success")
        {
            lblResponseMessage.Text = "Email Sent Successfully!";
        }
        else
        {
            lblResponseMessage.Text = res;
        }
        

    }

    private string PopulateBody(string userName, string serviceName, string serviceAmount)
    {
        string body = string.Empty;
        using (StreamReader reader = new StreamReader(Server.MapPath("~/assets/emailTemplate.html")))
        {
            body = reader.ReadToEnd();
        }
        body = body.Replace("{UserName}", userName);
        body = body.Replace("{ServiceName}", serviceName);
        body = body.Replace("{ServiceAmount}", serviceAmount);
        return body;
    }
}