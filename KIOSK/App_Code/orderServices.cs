using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using CommonDTO;
using CommonDTO.Entities;
using CreditCardValidator;
using System.Data.Entity.Validation;
using AuthorizeNet.Api.Contracts.V1;

/// <summary>
/// Summary description for orderServices
/// </summary>
[WebService(Namespace = "http://svlt.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class orderServices : System.Web.Services.WebService
{
    public orderServices()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public void processNewOrder(OrderedData orderedData)
    {
        Boolean validRequest = validateRequest(orderedData);
        if (validRequest)
        {
            SaveNewOrder(orderedData);
        }
    }
    private void SaveNewOrder(OrderedData orderedData)
    {
        JavaScriptSerializer js = new JavaScriptSerializer();
        Data _data = new Data();
        //paymentResponse response = new paymentResponse();
        ANetResponse response = new ANetResponse();
        OrderResponse res = new OrderResponse();
        List<OrderItem> ois = new List<OrderItem>();
        Context.Response.Clear();
        devoteeInfo di = new devoteeInfo(orderedData.DevoteeId.ToString());

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
                        devoteeID = orderedData.DevoteeId,
                        MailAddressId = 0,
                        paymentMethodName = orderedData.paymentMethodName,
                        orderTotal = orderedData.orderTotal,
                        orderItemCount = Convert.ToInt16(orderedData.orderItemCount),
                        refundedAmount = 0,
                        comment1 = orderedData.Comment1,
                        comment2 = orderedData.Comment2,
                        comment3 = orderedData.Comment3,
                        orderCreatedBy = orderedData.orderCreatedBy,
                        checkDepositDate = "",
                        checkDepositRegisteredBy = "",
                        refundTransactionId = "",
                        refundTransactionCode = ""
                    };
                    switch (orderedData.paymentMethodName)
                    {
                        case "CREDIT CARD":
                            //Prepare Credit Card Data
                            creditCardType CC = new creditCardType();
                            CC.cardNumber = orderedData.cardNumber;
                            CC.expirationDate = orderedData.cardExpiration;
                            CC.cardCode = orderedData.cardCVV2;

                            //Process the Credit Card Payment with Authorize.Net
                            response = ccProcessor.chargeCard(orderedData, di, CC);
                            //Process the Credit Card Payment with Authorize.Net
                            //response = processCCPayment(orderedData);

                            if (response.response.messages.resultCode == messageTypeEnum.Ok)
                            {
                                o.orderStatus = "Pending";
                                o.paymentStatus = "Success";
                                o.cardName = orderedData.cardName;
                                o.cardNumberMasked = response.transResponse.accountNumber;
                                o.cardType = orderedData.cardNumber.CreditCardBrandName();
                                o.cardCVV2 = orderedData.cardCVV2;
                                o.cardExpirationMonth = orderedData.cardExpiration;
                                o.cardExpirationYear = orderedData.cardExpiration;
                                o.authorizationTransactionCode = response.transResponse.authCode;
                                o.authorizationTransactionId = response.transResponse.transId;
                            }
                            else
                            {
                                o.orderStatus = "Pending Payment";
                                o.paymentStatus = "Failed";
                            }
                            break;
                        default:
                            o.orderStatus = "Pending";
                            o.paymentStatus = "Success";
                            break;
                    }

                    var cartItems = orderedData.CartList;
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
                            itemStatus = "Pending"
                        };
                        context.OrderItems.Add(oi);
                    }

                    context.Orders.Add(o);
                    context.SaveChanges();
                    dbContextTransaction.Commit();

                    res.resultCode = 1;
                    res.message = "Order Created Successfully";
                    res.orderId = o.Id;
                    Context.Response.Write(js.Serialize(res));
                }
                catch (DbEntityValidationException eve)
                {
                    res.resultCode = 0;
                    res.message = "Order Creation Failed due to: '" +
                                    eve.EntityValidationErrors.ToString() + "'";
                    res.orderId = null;
                    Context.Response.Write(js.Serialize(res));
                    dbContextTransaction.Rollback();
                }
                catch (Exception ex)
                {
                    res.resultCode = 0;
                    res.message = "Order Creation Failed due to: '" + 
                                    ex.Message.ToString() + "'";
                    res.orderId = null;
                    Context.Response.Write(js.Serialize(res));
                    dbContextTransaction.Rollback();
                }
            }
        }
        Context.Response.Flush();
        Context.Response.End();
    }
    private Boolean validateRequest(OrderedData orderedData)
    {
        Boolean response = true;
        switch (orderedData.paymentMethodName)
        {
            case "Credit Card":
                CreditCardDetector detector = new CreditCardDetector(orderedData.cardNumber);
                if (!detector.IsValid() | !Luhn.CheckLuhn(orderedData.cardNumber))
                    response = false;
                if (orderedData.cardCVV2 == "")
                    response = false;
                if (orderedData.cardNumber.CreditCardBrand() == CardIssuer.AmericanExpress && orderedData.cardCVV2.Length != 4)
                    response = false;
                break;
            default:
                break;
        }
        return response;
    }
}