using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for BaseMasterPage
/// </summary>
public class BaseMasterPage: System.Web.UI.MasterPage
{
	public BaseMasterPage()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public void LogActivity(string activity, bool recordPageUrl, string url)
    {
        // Get information about the currently logged on user
        MembershipUser currentUser = Membership.GetUser(false);
        if (currentUser != null)
        {
            Guid userId = (Guid)currentUser.ProviderUserKey;
            // Log the activity in the database
            using (SqlConnection myConnection = new
               SqlConnection(ConfigurationManager.
               ConnectionStrings["ApplicationServices"].ConnectionString))
            {
                SqlCommand myCommand = new SqlCommand();
                myCommand.CommandText = "usp_LogUserActivity";
                myCommand.CommandType = CommandType.StoredProcedure;
                myCommand.Connection = myConnection;
                myCommand.Parameters.AddWithValue("@UserId", userId);
                myCommand.Parameters.AddWithValue("@Activity", activity);
                if (recordPageUrl)
                    myCommand.Parameters.AddWithValue("@PageUrl", url);
                else
                    myCommand.Parameters.AddWithValue("@PageUrl", DBNull.Value);
                myConnection.Open();
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }
    }
}