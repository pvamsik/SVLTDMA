using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using CommonDTO;
using CommonDTO.Entities;
using System.Web.Script.Services;
using AuthorizeNet.Api.Controllers;
using AuthorizeNet.Api.Contracts.V1;
using AuthorizeNet.Api.Controllers.Bases;
using CreditCardValidator;

/// <summary>
/// Summary description for getLastName
/// </summary>
[System.Web.Script.Services.ScriptService]
public class myServices : System.Web.Services.WebService
{
    [WebMethod]
    public List<string> getLastNames(string prefixText, int count, string contextKey)
    {

        Data data = new Data();

        List<NameValueDTO> d = data.GetDevoteeLastName(prefixText);
        List<string> Names = new List<string>();

        d.ForEach(delegate (NameValueDTO dto)
        {
            Names.Add(dto.Name);
        });

        return Names;


        //List<string> Names = new List<string>();

        //DataTable dt = new DataTable();
        //string constr = ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString();
        //SqlConnection con = new SqlConnection(constr);
        //con.Open();
        //SqlCommand cmd = new SqlCommand("SELECT [Devotee_Last_Name] FROM [Devotee] WHERE [Devotee_Last_Name] LIKE @lname+'%'", con);
        //cmd.Parameters.AddWithValue("@lname", prefixText);
        //SqlDataAdapter adp = new SqlDataAdapter(cmd);
        //adp.Fill(dt);

        //for (int i = 0; i < dt.Rows.Count; i++)
        //{
        //    //Names.Add(dt.Rows[i][0].ToString());
        //}
        //return (from m in Names
        //        where m.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase)
        //        select m).Take(count).ToList();
    }
    [WebMethod]
    public List<string> getFirstNames(string prefixText, int count, string contextKey)
    {

        Data data = new Data();

        List<NameValueDTO> d = data.GetDevoteeFirstName(prefixText);
        List<string> Names = new List<string>();

        d.ForEach(delegate (NameValueDTO dto)
        {
            Names.Add(dto.Name);
        });

        return Names;
        //List<string> Names = new List<string>();

        //DataTable dt = new DataTable();
        //string constr = ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString();
        //SqlConnection con = new SqlConnection(constr);
        //con.Open();

        //SqlCommand cmd = new SqlCommand();
        //cmd.Connection = con;
        //switch (contextKey)
        //{
        //    case "FName":
        //        cmd.CommandText = "SELECT [Devotee_First_Name] FROM [Devotee] WHERE [Devotee_First_Name] LIKE @fname+'%'";
        //        cmd.Parameters.AddWithValue("@fname", prefixText);
        //        break;
        //    case "LName":
        //        cmd.CommandText = "SELECT [Devotee_Last_Name] FROM [Devotee] WHERE [Devotee_Last_Name] LIKE @lname+'%'";
        //        cmd.Parameters.AddWithValue("@lname", prefixText);
        //        break;
        //    default:
        //        break;
        //}

        //SqlDataAdapter adp = new SqlDataAdapter(cmd);
        //try
        //{
        //    adp.Fill(dt);
        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        Names.Add(dt.Rows[i][0].ToString());
        //    }
        //    return (from m in Names
        //            where m.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase)
        //            select m).Take(count).ToList();
        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}
    }
    [WebMethod]
    public List<string> getPhoneNumbers(string prefixText, int count, string contextKey)
    {

        Data data = new Data();

        List<NameValueDTO> d = data.GetDevoteePhoneNumber(prefixText);
        List<string> Names = new List<string>();

        d.ForEach(delegate (NameValueDTO dto)
        {
            Names.Add(dto.Name);
        });

        return Names;

        //List<string> Phones1 = new List<string>();
        //List<string> Phones2 = new List<string>();

        //DataTable dt = new DataTable();
        //string constr = ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString();
        //SqlConnection con = new SqlConnection(constr);
        //con.Open();
        //SqlCommand cmd = new SqlCommand("SELECT [Devotee_Phone1] FROM [dbo].[Devotee_Contact_Info] WHERE [Devotee_Phone1] LIKE @phone+'%'", con);
        //cmd.Parameters.AddWithValue("@phone", prefixText);
        //SqlDataAdapter adp = new SqlDataAdapter(cmd);
        //try
        //{
        //    adp.Fill(dt);

        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        Phones1.Add(dt.Rows[i][0].ToString());
        //    }
        //    //Second Query
        //    cmd.CommandText = "SELECT [Devotee_Phone2] FROM [dbo].[Devotee_Contact_Info] WHERE [Devotee_Phone2] LIKE +'%'+@phone+'%'";
        //    try
        //    {
        //        adp.Fill(dt);
        //        for (int i = 0; i < dt.Rows.Count; i++)
        //        {
        //            Phones2.Add(dt.Rows[i][0].ToString());
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }

        //    Phones1 = Phones1.Union(Phones2).ToList();
        //    return (from m in Phones1
        //            where m.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase)
        //            select m).Take(count).ToList();
        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}
    }
    [WebMethod]
    public void getServices()
    {
        JavaScriptSerializer js = new JavaScriptSerializer();
        Data _data = new Data();

        List<ServiceTypeDTO> _serviceTypes = _data.GetServiceTypes();
        List<ServiceDTO> _services = _data.GetServices();
        List<PaymentTypeDTO> _paymentTypes = _data.GetPaymentTypes();
        List<CreditCardTypeDTO> _creditCardTypes = _data.GetCreditCardTypes();

        List<CartItems> _serviceList = new List<CartItems>();
        _services.ForEach(delegate (ServiceDTO s)
        {
            _serviceList.Add(new CartItems() { Service = s, Service_ID = s.Service_ID });
        });

        var _mList = new OrderMasterData
        {
            ServiceTypes = _data.GetServiceTypes(),
            Services = _services,
            PaymentTypes = _data.GetPaymentTypes(),
            CreditCardTypes = _data.GetCreditCardTypes(),
            ServiceList = _serviceList
        };

        Context.Response.Write(js.Serialize(_mList));

    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="OrderData"></param>
    [WebMethod]
    public void processOrder(OrderedData OrderData)
    {
        JavaScriptSerializer js = new JavaScriptSerializer();
        OrderResponse response = new OrderResponse();
        Context.Response.Clear();

        if (!String.IsNullOrEmpty(OrderData.DevoteeId.ToString()))
        {
            devoteeInfo di = getDevotee(OrderData.DevoteeId.ToString());
            
            using (OrderEntities context = new OrderEntities())
            {
                using (var dbContextTransaction = context.Database.BeginTransaction())
                {
                    try
                    {
                        //Create new Storage Order using EF
                        Order o = new Order
                        {
                            orderGuid = Guid.NewGuid(),
                            orderDate = DateTime.Today.ToShortDateString(),
                            devoteeID = OrderData.DevoteeId,
                            MailAddressId = 0,
                            paymentMethodName = OrderData.paymentMethodName,
                            orderTotal = OrderData.orderTotal,
                            orderItemCount = Convert.ToInt16(OrderData.orderItemCount),
                            refundedAmount = 0,
                            comment1 = OrderData.Comment1,
                            comment2 = OrderData.Comment2,
                            comment3 = OrderData.Comment3,
                            orderCreatedBy = OrderData.orderCreatedBy,
                            checkDepositDate = "",
                            checkDepositregisteredBy = "",
                            refundTransactionId = "",
                            refundTransactionCode = ""
                    };

                    //Populate Payment Type Specific Information
                    switch (OrderData.paymentMethodName)
                        {
                            case "CREDIT CARD":
                                //Prepare Credit Card Data
                                creditCardType CC = new creditCardType();
                                CC.cardNumber = OrderData.cardNumber;
                                CC.expirationDate = OrderData.cardExpiration;
                                CC.cardCode = OrderData.cardCVV2;

                                //Process the Credit Card Payment with Authorize.Net
                                ANetResponse res = ccProcessor.chargeCard(OrderData, di, CC);

                                if (res.response.messages.resultCode == messageTypeEnum.Ok)
                                {
                                    o.orderStatus = "Completed";
                                    o.paymentStatus = "Success";
                                    o.cardName = OrderData.cardName;
                                    o.cardNumberMasked = res.transResponse.accountNumber;
                                    o.cardType = ccBrandName(CC.cardNumber);
                                    o.cardCVV2 = OrderData.cardCVV2;
                                    o.cardExpirationMonth = CC.expirationDate;
                                    o.cardExpirationYear = CC.expirationDate;
                                    o.authorizationTransactionCode = res.transResponse.authCode;
                                    o.authorizationTransactionId = res.transResponse.transId;
                                }
                                else
                                {
                                    o.orderStatus = "Pending";
                                    o.paymentStatus = "Failed";
                                }
                                break;
                            case "CHECK":
                                o.orderStatus = "Completed";
                                o.paymentStatus = "Success";
                                o.checkDate = DateTime.Parse(OrderData.checkDate);
                                o.checkNumber = OrderData.checkNumber;
                                break;
                            default:
                                o.orderStatus = "Completed";
                                o.paymentStatus = "Success";
                                break;
                        }

                        var cartItems = OrderData.CartList;

                        foreach (var item in cartItems)
                        {
                            OrderItem oi = new OrderItem
                            {
                                orderItemGuid = Guid.NewGuid(),
                                OrderId = o.Id,
                                serviceDate = item.orderDate,
                                serviceId = item.Service_ID,
                                serviceName = item.Service.Service_Name,
                                quantity = item.Quantity,
                                price = item.Quantity * item.Service.Service_Fee,
                                comments = item.comment,
                                itemStatus = "Completed"
                            };
                            context.OrderItems.Add(oi);
                        }

                        context.Orders.Add(o);
                        context.SaveChanges();
                        dbContextTransaction.Commit();

                        response.resultCode = 1;
                        response.message = "Order Created Successfully";
                        response.orderId = o.Id;
                        Context.Response.Write(js.Serialize(response));
                    }
                    catch (Exception ex)
                    {
                        response.resultCode = 0;
                        response.message = "Order Creation Failed due to: '" + ex.Message.ToString() + "'";
                        response.orderId = null;
                        Context.Response.Write(js.Serialize(response));
                        dbContextTransaction.Rollback();
                    }
                }
            }
        }
        Context.Response.Flush();
        Context.Response.End();
    }

    public myServices()
    {
    }
    #region private
    private class OrderMasterData
    {
        public List<ServiceTypeDTO> ServiceTypes { get; set; }
        public List<ServiceDTO> Services { get; set; }
        public List<PaymentTypeDTO> PaymentTypes { get; set; }
        public List<CreditCardTypeDTO> CreditCardTypes { get; set; }
        public List<CartItems> ServiceList { get; set; }
    }
    private devoteeInfo getDevotee(string id)
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
    #endregion private

    #region Test Modules
    //[ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
    [WebMethod]
    public void testPostData(string test)
    {
        JavaScriptSerializer js = new JavaScriptSerializer();
        Data _data = new Data();

        List<CreditCardTypeDTO> _creditCardTypes = _data.GetCreditCardTypes();

        //Context.Response.Write(js.Serialize(_creditCardTypes));

        Context.Response.Clear();
        Context.Response.Write(js.Serialize(_creditCardTypes));
        Context.Response.Flush();
        Context.Response.End();
    }
    #endregion Test Modules
}
