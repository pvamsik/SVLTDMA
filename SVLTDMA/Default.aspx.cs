using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.User.Identity.IsAuthenticated == true)
        {
            Response.Redirect("~/devotee/searchDevotee.aspx");
        }
    }
    protected void siteLogin_LoggedIn(object sender, EventArgs e)
    {
        AppLogger al = new AppLogger();
        al.LogActivity(siteLogin.UserName, "User Logged In", HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath);
        String[] rolesforuser = Roles.GetRolesForUser(siteLogin.UserName.ToString());
        Session.Add("UserRole", rolesforuser[0]);
        //base.LogActivity("User Logged In", true, Request.RawUrl);
    }
}