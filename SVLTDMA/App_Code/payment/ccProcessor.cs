using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AuthorizeNet.Api.Controllers;
using AuthorizeNet.Api.Contracts.V1;
using AuthorizeNet.Api.Controllers.Bases;
using System.Configuration;
using CommonDTO;

/// <summary>
/// Summary description for ccProcessor
/// </summary>
public static class ccProcessor
{
    /// <summary>
    /// Capture a Authorize and Capture a transaction.
    /// </summary>
    /// <param name="creditCardType">Credit Card Object containing Number, Expiration (mm/yy) and CVV Code</param>
    /// <param name="shoppingCart">The Shopping Cart with all its items</param>
    /// <param name="devoteeInfo">The Devotee Information Object containg all devotee related information</param>
    /// <example>
    ///     This sample shows how to call the ChargeCard method.
    ///     <code>
    ///         ANetResponse response = ccProcessor.ChargeCard(shoppingCart, devoteeInfo, creditCardType);
    ///     </code>
    /// </example>
    /// <returns>
    ///     The response is a 2 part response. It contains: 
    ///     1. ANetApiResponse: 
    ///         Transaction Messages
    ///     2. transactionResponse:
    ///         Transaction ID
    ///         Authorization Code
    ///         Result Code
    ///         CVV Result Code along with other information
    /// </returns>
    public static ANetResponse chargeCard(shoppingCart shoppingCart, devoteeInfo devoteeInfo, creditCardType creditCardType)
    {
        Console.WriteLine("Charge Credit Card Sample");

        string environment = ConfigurationManager.AppSettings["AuthorizeNetTestMode"];
        if (!string.IsNullOrEmpty(environment) && environment == "true")
        {
            ApiOperationBase<ANetApiRequest, ANetApiResponse>.RunEnvironment = AuthorizeNet.Environment.SANDBOX;
        }
        else
        {
            ApiOperationBase<ANetApiRequest, ANetApiResponse>.RunEnvironment = AuthorizeNet.Environment.PRODUCTION;
        }

        // define the merchant information (authentication / transaction id)
        ApiOperationBase<ANetApiRequest, ANetApiResponse>.MerchantAuthentication = new merchantAuthenticationType()
        {
            ItemElementName = ItemChoiceType.transactionKey,
            name = ConfigurationManager.AppSettings["AuthorizeNetCNPLogin"],
            Item = ConfigurationManager.AppSettings["AuthorizeNetCNPTransactionKey"]
        };

        var creditCard = creditCardType;

        var billingAddress = new customerAddressType
        {
            firstName = devoteeInfo.firstName,
            lastName = devoteeInfo.lastName,
            address = devoteeInfo.address1 + " " + devoteeInfo.address2,
            city = devoteeInfo.city,
            zip = devoteeInfo.zip
        };

        //standard api call to retrieve response
        var paymentType = new paymentType { Item = creditCard };
        var lineItems = new lineItemType[shoppingCart.GetCartCount()];
        int i = 0;
        foreach (var cartItem in shoppingCart.GetCartItems())
        {
            string serviceName = cartItem.Service.Service_Name;
            if (serviceName.Length > 30)
            {
                serviceName = serviceName.Substring(0, 30);
            }
            lineItems[i] = new lineItemType { itemId = cartItem.Service_ID.ToString(), name = serviceName, quantity = cartItem.Quantity, unitPrice = cartItem.Service.Service_Fee };
            i++;
        }

        var transactionRequest = new transactionRequestType
        {
            transactionType = transactionTypeEnum.authCaptureTransaction.ToString(),    // charge the card

            amount = shoppingCart.GetTotal(),
            payment = paymentType,
            billTo = billingAddress,
            lineItems = lineItems
        };

        var request = new createTransactionRequest { transactionRequest = transactionRequest };

        // instantiate the contoller that will call the service
        var controller = new createTransactionController(request);
        controller.Execute();

        // get the response from the service (errors contained if any)
        var response = controller.GetApiResponse();

        ANetResponse res = new ANetResponse();
        res.response = response;
        res.transResponse = response.transactionResponse;
        return res;
    }

    public static ANetResponse chargeCard(OrderedData OrderData, devoteeInfo devoteeInfo, creditCardType creditCardType)
    {
        Console.WriteLine("Charge Credit Card Sample");

        string environment = ConfigurationManager.AppSettings["AuthorizeNetTestMode"];
        if (!string.IsNullOrEmpty(environment) && environment == "true")
        {
            ApiOperationBase<ANetApiRequest, ANetApiResponse>.RunEnvironment = AuthorizeNet.Environment.SANDBOX;
        }
        else
        {
            ApiOperationBase<ANetApiRequest, ANetApiResponse>.RunEnvironment = AuthorizeNet.Environment.PRODUCTION;
        }

        // define the merchant information (authentication / transaction id)
        ApiOperationBase<ANetApiRequest, ANetApiResponse>.MerchantAuthentication = new merchantAuthenticationType()
        {
            ItemElementName = ItemChoiceType.transactionKey,
            name = ConfigurationManager.AppSettings["AuthorizeNetCNPLogin"],
            Item = ConfigurationManager.AppSettings["AuthorizeNetCNPTransactionKey"]
        };

        var creditCard = creditCardType;

        var billingAddress = new customerAddressType
        {
            firstName = devoteeInfo.firstName,
            lastName = devoteeInfo.lastName,
            address = devoteeInfo.address1 + " " + devoteeInfo.address2,
            city = devoteeInfo.city,
            zip = devoteeInfo.zip
        };

        //standard api call to retrieve response
        var paymentType = new paymentType { Item = creditCard };
        var lineItems = new lineItemType[OrderData.orderItemCount];
        int i = 0;
        foreach (var cartItem in  OrderData.CartList)
        {
            string serviceName = cartItem.Service.Service_Name;
            if (serviceName.Length > 30)
            {
                serviceName = serviceName.Substring(0, 30);
            }
            lineItems[i] = new lineItemType { itemId = cartItem.Service_ID.ToString(), name = serviceName, quantity = cartItem.Quantity, unitPrice = cartItem.Service.Service_Fee };
            i++;
        }

        var transactionRequest = new transactionRequestType
        {
            transactionType = transactionTypeEnum.authCaptureTransaction.ToString(),    // charge the card

            amount = OrderData.orderTotal,
            payment = paymentType,
            billTo = billingAddress,
            lineItems = lineItems
        };

        var request = new createTransactionRequest { transactionRequest = transactionRequest };

        // instantiate the contoller that will call the service
        var controller = new createTransactionController(request);
        controller.Execute();

        // get the response from the service (errors contained if any)
        var response = controller.GetApiResponse();

        ANetResponse res = new ANetResponse();
        res.response = response;
        res.transResponse = response.transactionResponse;
        return res;
    }

    /// <summary>
    ///     Refund a previously authorized transaction.
    /// </summary>
    /// <param name="transactionRequestType">AuthorizeNet Transaction request Type.</param>
    /// <example>
    ///     This sample shows how to call the ChargeCard method.
    ///     <code>
    ///         ANetApiResponse response = ccProcessor.refundTransaction(transactionRequestType);
    ///     </code>
    /// </example>
    /// <returns>
    ///     The response contains an ANetApiResponse including Approve/Reject Transaction Messages.
    /// </returns>
    public static ANetApiResponse refundTransaction(transactionRequestType transactionRequestType)
    {

        ApiOperationBase<ANetApiRequest, ANetApiResponse>.RunEnvironment = AuthorizeNet.Environment.SANDBOX;

        // define the merchant information (authentication / transaction id)
        ApiOperationBase<ANetApiRequest, ANetApiResponse>.MerchantAuthentication = new merchantAuthenticationType()
        {
            ItemElementName = ItemChoiceType.transactionKey,
            name = ConfigurationManager.AppSettings["AuthorizeNetCNPLogin"],
            Item = ConfigurationManager.AppSettings["AuthorizeNetCNPTransactionKey"]
        };

        var request = new createTransactionRequest { transactionRequest = transactionRequestType };

        // instantiate the contoller that will call the service
        var controller = new createTransactionController(request);
        controller.Execute();

        // get the response from the service (errors contained if any)
        var response = controller.GetApiResponse();

        return response;
    }
    public static string getTransactionStatus(string transactionId)
    {
        string option = "";
        ApiOperationBase<ANetApiRequest, ANetApiResponse>.RunEnvironment = AuthorizeNet.Environment.SANDBOX;

        // define the merchant information (authentication / transaction id)
        ApiOperationBase<ANetApiRequest, ANetApiResponse>.MerchantAuthentication = new merchantAuthenticationType()
        {
            name = ConfigurationManager.AppSettings["AuthorizeNetCNPLogin"],
            ItemElementName = ItemChoiceType.transactionKey,
            Item = ConfigurationManager.AppSettings["AuthorizeNetCNPTransactionKey"]
        };

        var request = new getTransactionDetailsRequest();
        request.transId = transactionId;

        // instantiate the controller that will call the service
        var controller = new getTransactionDetailsController(request);
        controller.Execute();

        // get the response from the service (errors contained if any)
        var response = controller.GetApiResponse();

        if (response != null)
        {
            if (response.messages.resultCode == messageTypeEnum.Ok)
            {
                option = response.transaction.transactionStatus;
            }
            else
            {
                option = "No Action";
            }
        }
        else
        {
            option = "No Action";
        }

        return option;
    }
    public static ANetResponse submitTransaction(paymentType paymentType, creditCardType creditCard, transactionRequestType transactionRequest)
    {

        ApiOperationBase<ANetApiRequest, ANetApiResponse>.RunEnvironment = AuthorizeNet.Environment.SANDBOX;

        // define the merchant information (authentication / transaction id)
        ApiOperationBase<ANetApiRequest, ANetApiResponse>.MerchantAuthentication = new merchantAuthenticationType()
        {
            name = ConfigurationManager.AppSettings["AuthorizeNetCNPLogin"],
            ItemElementName = ItemChoiceType.transactionKey,
            Item = ConfigurationManager.AppSettings["AuthorizeNetCNPTransactionKey"]
        };

        var request = new createTransactionRequest { transactionRequest = transactionRequest };

        // instantiate the contoller that will call the service
        var controller = new createTransactionController(request);
        controller.Execute();

        // get the response from the service (errors contained if any)
        var response = controller.GetApiResponse();

        //Send the Request and Response Details
        ANetResponse res = new ANetResponse();
        res.response = response;
        res.transResponse = response.transactionResponse;
        return res;

    }


}