using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using CommonDTO;
using CreditCardValidator;
using System.IO;
using CommonDTO.Entities;

public class BasePage : System.Web.UI.Page
{
    public Data data;

    public BasePage()
    {
        data = new Data();
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        AutoRedirect();
    }

    public void AutoRedirect()
    {

        int int_MilliSecondsTimeOut = (this.Session.Timeout * 60000);
        string str_Script = @"<script type='text/javascript'>
                                intervalset = window.setInterval('Redirect()'," + int_MilliSecondsTimeOut.ToString() + @");
                                function Redirect()
                                {
                                    alert('Your session has been expired and system redirects to login page now.!\n\n');
                                    window.location.href='/default.aspx';
                                }
                            </script>";
        ClientScript.RegisterClientScriptBlock(this.GetType(), "Redirect", str_Script);

    }
    public string processCommentData(string commentData)
    {
        string result = "";
        //var jsonSerialiser = new JavaScriptSerializer();
        List<string> comments = (List<string>)Newtonsoft.Json.JsonConvert.DeserializeObject(commentData, typeof(List<string>));
        foreach (var comment in comments)
        {
            if (!string.IsNullOrEmpty(comment))
                result += comment + "<br />";
        }
        return result.Trim();
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
    public string PopulateBody(devoteeInfo di, Order order)
    {
        Order myOrder = order;
        string body = string.Empty;
        if(order.orderStatus == "Completed")
        {
            using (StreamReader reader = new StreamReader(Server.MapPath("~/assets/emailOrderReceiptTemplate.html")))
            {
                body = reader.ReadToEnd();
            }
            string orderItems = "";
            foreach (var item in myOrder.OrderItems)
            {
                orderItems += "<tr>";
                orderItems += "<td>" + item.serviceDate + "</td>";
                orderItems += "<td>" + item.serviceName + "</td>";
                orderItems += "<td class='alignRight'>" + string.Format("{0:N0}", item.quantity) + "</td>";
                orderItems += "<td class='alignRight'>" + string.Format("{0:c}", item.price) + "</td>";
                orderItems += "</tr>";
            }
            body = body.Replace("{UserName}", di.firstName + " " + di.lastName);
            body = body.Replace("{orderItems}", orderItems);
            body = body.Replace("{orderQuantity}", string.Format("{0:N0}", myOrder.orderItemCount));
            body = body.Replace("{orderAmount}", string.Format("{0:c}", myOrder.orderTotal));
        }
        if(order.orderStatus == "Cancelled")
        {
            using (StreamReader reader = new StreamReader(Server.MapPath("~/assets/emailOrderRefundTemplate.html")))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{UserName}", di.firstName + " " + di.lastName);
            body = body.Replace("{refundAmount}", string.Format("{0:c}", order.orderTotal));
        }
        return body;
    }

    public string PopulateHeader(string orderStatus)
    {

        string header = string.Empty;
        switch (orderStatus)
        {
            case "Completed":
                header = "Thank You for your Order";
                break;
            case "Cancelled":
                header = "Your Order Cancellation confirmation";
                break;
            default:
                header = "Thank You for your Order";
                break;
        }
        return header;
    }
    public string createErrorMessage(string message, string messageType, int duration)
    {
        string res = "";
        if(messageType == "Error")
        {
            res = "<script>$(document).ready(function() { $('#message').fadeOut( { duration:" + duration + " }, function() { $this.remove(); } ); });</script><div id='message' class='alert alert-dismissible alert-danger'>";
            res += message;
            res += "</div>";
        }
        return res;
    }
    public string createMessagePanel(string message, string messageType, int duration)
    {
        string res = "";
        if (messageType == "Error")
        {
            res = "<script>$(document).ready(function() { $('#message').fadeOut( { duration:" + duration + " }, function() { $this.remove(); } );});</script>";
            res += "<div id='message' class='panel panel-danger'><div class='panel-heading'><h3 class='panel-title'>Error</h3></div>";
            res += "<div class='panel-body'>";
            res += message;
            res += "</div></div>";
        }
        if (messageType == "Success")
        {
            res = "<script>$(document).ready(function() { $('#message').fadeOut( { duration:" + duration + " }, function() { $this.remove(); } );});</script>";
            res += "<div id='message' class='panel panel-success'><div class='panel-heading'><h3 class='panel-title'>Success</h3></div>";
            res += "<div class='panel-body'>";
            res += message;
            res += "</div></div>";
        }
        return res;
    }
    public static string GetRandomPassword(int length)
    {
        char[] chars = "$%#@!*abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ&".ToCharArray();
        string password = string.Empty;
        Random random = new Random();

        for (int i = 0; i < length; i++)
        {
            int x = random.Next(1, chars.Length);
            //Don't Allow Repetation of Characters
            if (!password.Contains(chars.GetValue(x).ToString()))
                password += chars.GetValue(x);
            else
                i--;
        }
        return password;
    }

    public devoteeInfo getDevotee(string id)
    {
        devoteeInfo di;
        if (id != "")
        {
            //Populate the Devotee Info
            di = new devoteeInfo(id);
        }
        else
        {
            di = new devoteeInfo();
            di.lastName = "Undefined";
        }
        return di;
    }

    public ClientDTO getClientInfo(string ipAddress)
    {
        ClientDTO client = new ClientDTO();
        if (Clients != null)
        {
            client = Clients.Where(x => x.ClientIP == ipAddress).SingleOrDefault();

            if (string.IsNullOrEmpty(client.PrinterSettings))
                client.PrinterSettings = "";
        }
        return client;
    }


    /// <summary>
    /// Gets the ServiceTypes from Application variable 
    /// </summary>
    public List<ServiceTypeDTO> ServiceTypes
    {
        get
        {
            if (Application["serviceTypes"] != null)
                return (List<ServiceTypeDTO>)Application["serviceTypes"];
            else
                return data.GetServiceTypes();
        }
    }

    /// <summary>
    /// Gets the Services from Application variable 
    /// </summary>
    public List<ServiceDTO> Services
    {
        get
        {
            if (Application["services"] != null)
                return (List<ServiceDTO>)Application["services"];
            else
                return data.GetServices();
        }
    }

    /// <summary>
    /// Gets the Services from Application variable 
    /// </summary>
    public List<ClientDTO> Clients
    {
        get
        {
            if (Application["clients"] != null)
                return (List<ClientDTO>)Application["clients"];
            else
                return data.GetClients();
        }
    }

    public List<DevoteeDTO> Devotees
    {
        get
        {
            if (Application["devotees"] != null)
                return (List<DevoteeDTO>)Application["devotees"];
            else
                return data.GetAllDevotees();
        }
    }

    public List<PaymentTypeDTO> PaymentTypes
    {
        get
        {
            if (Application["paymentTypes"] != null)
                return (List<PaymentTypeDTO>)Application["paymentTypes"];
            else
                return data.GetPaymentTypes();
        }
    }

    public List<CreditCardTypeDTO> CreditCardTypes
    {
        get
        {
            if (Application["creditCardTypes"] != null)
                return (List<CreditCardTypeDTO>)Application["creditCardTypes"];
            else
                return data.GetCreditCardTypes();
        }
    }

    public List<PriestDTO> Priests
    {
        get
        {
            if (Application["priests"] != null)
                return (List<PriestDTO>)Application["priests"];
            else
                return data.GetPriests();
        }
    }

    public string ccBrandName(string cardNumber)
    {
        CreditCardDetector detector = new CreditCardDetector(cardNumber);
        if (detector.IsValid())
        {
            return detector.BrandName;
        }
        else
        {
            throw new Exception("Unknown Credit Card Type. Please use one of the following Card Types: American Express, Discover Card, Master Card, Visa");
        }
    }

    //public bool GetBoolean(object obj)
    //{
    //    bool flag = false;

    //    if (!bool.TryParse(obj == null ? "0" : obj.ToString(), out flag))
    //        flag = false;

    //    return flag;
    //}

    //public int GetInteger(object obj)
    //{
    //    int number = 0;

    //    if (!int.TryParse(obj == null ? "0" : obj.ToString(), out number))
    //        number = 0;

    //    return number;
    //}
}


