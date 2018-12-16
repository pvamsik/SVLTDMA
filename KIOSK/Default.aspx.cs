using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.User.Identity.IsAuthenticated == true)
        {
            Response.Redirect(Resources.Links.Kiosk);
        }
    }

    protected void siteLogin_LoggedIn(object sender, EventArgs e)
    {
        AppLogger al = new AppLogger();
        al.LogActivity(loginForm.UserName, "User Logged In", HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath);
        String[] rolesforuser = Roles.GetRolesForUser(loginForm.UserName.ToString());
        Session.Add("UserRole", rolesforuser[0]);
    }
}