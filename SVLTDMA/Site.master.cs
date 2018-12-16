using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class NewSite : BaseMasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            printerStatus.ImageUrl = CheckPrinterStatus();
            UpdatePanel1.Update();
            UpdatePanel1.Visible = true;
        }
        else
        {
            UpdatePanel1.Visible = false;
        }
    }
    protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
    {
        AppLogger al = new AppLogger();
        al.LogActivity(HttpContext.Current.User.Identity.Name, "User Logged Out", HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath);
    }

    protected void Timer_Tick(object sender, EventArgs e)
    {
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            printerStatus.ImageUrl = CheckPrinterStatus();
            UpdatePanel1.Update();
            UpdatePanel1.Visible = true;
        }
        else
        {
            UpdatePanel1.Visible = false;
        }
    }

    public string CheckPrinterStatus()
    {
        string[] ps = new string[2];
        ps = getPrintersettings();
        printManager pm = new printManager(ps[0], ps[1]);
        if (pm.testPrinterStatus() == true)
        {
            return "~/Images/online.png";
        }
        else
        {
            return "~/Images/offline.png";
        }
    }

    public string[] getPrintersettings()
    {
        string[] ps = new string[2];
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString());
        string sql = "select * from [dbo].[printerSettings] where [ClientIP] = @clientIP";
        SqlDataReader res;
        SqlCommand com = new SqlCommand(sql, conn);
        com.Parameters.Add("@clientIP", SqlDbType.VarChar, 50).Value = GetUserIP();
        try
        {
            conn.Open();
            com.CommandType = CommandType.Text;
            res = com.ExecuteReader();

            while (res.Read())
            {
                ps[0] = res["printerPort"].ToString().Trim();
                ps[1] = res["printerSettings"].ToString().Trim();
            }
            res.Close();
        }
        catch (Exception ex)
        {

        }
        finally
        {
            conn.Close();
        }
        return ps;
    }

    private string GetUserIP()
    {
        return Request.UserHostAddress;
    }
}
