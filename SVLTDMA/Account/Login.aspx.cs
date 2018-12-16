using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void siteLogin_LoggedIn(object sender, EventArgs e)
    {
        AppLogger al = new AppLogger();
        al.LogActivity(siteLogin.UserName, "User Logged In", HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath);
        String[] rolesforuser = Roles.GetRolesForUser(siteLogin.UserName.ToString());
        Session.Add("UserRole", rolesforuser[0]);
        //base.LogActivity("User Logged In", true, Request.RawUrl);
    }

    protected void siteLogin_Authenticate(object sender, AuthenticateEventArgs e)
    {
        try
        {
            // Validate the user against the Membership framework user store
            if (Membership.ValidateUser(siteLogin.UserName, siteLogin.Password))
            {
                // Log the user into the site
                FormsAuthentication.RedirectFromLoginPage(siteLogin.UserName, siteLogin.RememberMeSet);
            }
            else
            {
                // If we reach here, the user's credentials were invalid
                siteLogin.FailureText = "Invalid User Credentials";
            }
        }
        catch (Exception ex)
        {
            siteLogin.FailureText = "Exception " + ex.HResult + ": Unable to authenticate user at this time. Please check your internet connection and also check that the Server is up and running";
        }
    }
}