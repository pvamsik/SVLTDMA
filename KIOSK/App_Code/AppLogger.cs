using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Providers.Entities;
using System.Web.Security;

/// <summary>
/// Summary description for AppLogger
/// </summary>
public class AppLogger
{
    private SqlConnection myConnection;
    private SqlCommand myCommand;
    public AppLogger()
    {
        myConnection = new
               SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
        myCommand = new SqlCommand();
        myCommand.CommandText = "usp_LogUserActivity";
        myCommand.CommandType = CommandType.StoredProcedure;
        myCommand.Connection = myConnection;
    }

    public AppLogger(string Activity)
    {
        myConnection = new
               SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
        myCommand = new SqlCommand();
        myCommand.CommandText = "usp_LogSearchActivity";
        myCommand.CommandType = CommandType.StoredProcedure;
        myCommand.Connection = myConnection;
    }

    public void LogActivity(string userName, string activity, string url)
    {
        MembershipUser currentUser = Membership.GetUser(userName);
        if (currentUser != null)
        {
            Guid userId = (Guid)currentUser.ProviderUserKey;
            using (myConnection)
            {
                myCommand.Parameters.AddWithValue("@UserId", userId);
                myCommand.Parameters.AddWithValue("@Activity", activity);
                myCommand.Parameters.AddWithValue("@PageUrl", url);
                myConnection.Open();
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
    }
    public void LogActivity(string activity)
    {
        // Get information about the currently logged on user
        MembershipUser currentUser = Membership.GetUser(false);
        if (currentUser != null)
        {
            Guid userId = (Guid)currentUser.ProviderUserKey;
            // Log the activity in the database
            using (myConnection)
            {
                myCommand.Parameters.AddWithValue("@UserId", userId);
                myCommand.Parameters.AddWithValue("@Activity", activity);
                myCommand.Parameters.AddWithValue("@PageUrl", "");
                myConnection.Open();
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
    }
    public void LogSearchActivity(string userName, string activity, string url)
    {
        MembershipUser currentUser = Membership.GetUser(userName);
        if (currentUser != null)
        {
            Guid userId = (Guid)currentUser.ProviderUserKey;
            using (myConnection)
            {
                myCommand.Parameters.AddWithValue("@UserId", userId);
                myCommand.Parameters.AddWithValue("@Activity", activity);
                myCommand.Parameters.AddWithValue("@PageUrl", url);
                myConnection.Open();
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
    }
}