using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AuthorizeNet;
using System.Configuration;
using System.Net;
using System.Xml;
using System.IO;
using System.Xml.Linq;
using System.Xml.XPath;

/// <summary>
/// Payment processor is a collection of API's to process payments. The class supports both 
/// Card Present and Card Not Present options. 
/// </summary>
public class paymentProcessor
{

    private string authorizeNetLogin { get; set; }
    private string authorizeNetTransactionKey { get; set; }
    private bool isTest { get; set; }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="transType"></param>
	public paymentProcessor(string transType)
	{
		//
		// Depending on the type of transaction, pickup the right Authorize.Net credentials
		//
        if (transType == "CP")
        {
            authorizeNetLogin = ConfigurationManager.AppSettings["AuthorizeNetCPLogin"];
            authorizeNetTransactionKey = ConfigurationManager.AppSettings["AuthorizeNetCPTransactionKey"];
            isTest = Convert.ToBoolean(ConfigurationManager.AppSettings["AuthorizeNetTestMode"]);
        }
        else if (transType == "CNP")
        {
            authorizeNetLogin = ConfigurationManager.AppSettings["AuthorizeNetCNPLogin"];
            authorizeNetTransactionKey = ConfigurationManager.AppSettings["AuthorizeNetCNPTransactionKey"];
            isTest = Convert.ToBoolean(ConfigurationManager.AppSettings["AuthorizeNetTestMode"]);
        }
	}

    //public paymentResponse processPaymentWithCard(decimal amount, string track1, string track2, devoteeInfo di)
    //{
    //    //step 1 - create the request
    //    var request = new CardPresentAuthorizeAndCaptureRequest(amount, track1, track2);
    //    request.FirstName = di.firstName;
    //    request.LastName = di.lastName;
    //    request.Address = (di.address1.Trim() + di.address2.Trim()).Trim();
    //    request.City = di.city;
    //    request.State = di.state;
    //    request.Zip = di.zip;
    //    //request.Email = di.email;

    //    //step 2 - create the gateway, sending in your credentials
    //    var gate = new CardPresentGateway(authorizeNetLogin, authorizeNetTransactionKey, isTest);

    //    //step 3 - make some money
    //    var response = (CardPresentResponse)gate.Send(request);

    //    paymentResponse pR = new paymentResponse();
    //    pR = populatePaymentResponse(response);
    //    pR.AVSResponse = response.AVSResponse;
    //    pR.CardCodeResponse = response.CardCodeResponse;
    //    pR.MD5Hash = response.MD5Hash;
    //    pR.RequestedAmount = response.RequestedAmount;
    //    pR.UserReference = response.UserReference;
    //    return pR;
    //}

    public paymentResponse processPaymentWithCard(decimal amount, string cardNumber, string expirationMonth, string expirationYear, devoteeInfo di)
    {
        //step 1 - create the request
        var request = new CardPresentAuthorizeAndCaptureRequest(amount, cardNumber, expirationMonth, expirationYear);
        if (di.lastName != "Undefined")
        {
            request.FirstName = di.firstName;
            request.LastName = di.lastName;
            request.Address = (di.address1.Trim() + di.address2.Trim()).Trim();
            request.City = di.city;
            request.State = di.state;
            request.Zip = di.zip;
            //request.Email = di.email;
        }

        //step 2 - create the gateway, sending in your credentials
        var gate = new CardPresentGateway(authorizeNetLogin, authorizeNetTransactionKey, isTest);

        //step 3 - make some money
        var response = (CardPresentResponse)gate.Send(request);

        paymentResponse pR = new paymentResponse();
        pR = populatePaymentResponse(response);
        pR.AVSResponse = response.AVSResponse;
        pR.CardCodeResponse = response.CardCodeResponse;
        pR.MD5Hash = response.MD5Hash;
        pR.RequestedAmount = response.RequestedAmount;
        pR.UserReference = response.UserReference;
        return pR;
    }

    /// <summary>
    /// This method allows you to process a credit card transaction as though the card is not present at hand. 
    /// </summary>
    /// <param name="creditCard">The 15 or 16 digit credit card number</param>
    /// <param name="CCExpCd">The Credit Card Expiration Date as 'mmyy'. Example: Send January 2014 as 0114</param>
    /// <param name="Amount">The Amount of the transaction</param>
    /// <param name="ServiceName">The Name of the Product being sold/purchased</param>
    /// <param name="devoteeInfo">The Devotee Information object containing personal information about the devotee</param>
    /// <returns>This methods returns an object of type paymentResponse</returns>
    /// <example>var request = new AuthorizationRequest("4111111111111111", "1216", 10.00M, "Test Transaction");</example>
    public paymentResponse processPaymentWithoutCard(string creditCard, string CCExpCd, decimal Amount, String ServiceName, devoteeInfo devoteeInfo)
    {
        paymentResponse pR = new paymentResponse();
        try
        {
            //step 1 - create the request
            var request = new AuthorizationRequest(creditCard, CCExpCd, Amount, ServiceName, true);
            if (devoteeInfo.lastName != "Undefined")
            {
                request.FirstName = devoteeInfo.firstName;
                request.LastName = devoteeInfo.lastName;
                request.Address = (devoteeInfo.address1.Trim() + devoteeInfo.address2.Trim()).Trim();
                request.City = devoteeInfo.city;
                request.State = devoteeInfo.state;
                request.Zip = devoteeInfo.zip;
                //request.Email = di.email;
            }

            //step 2 - create the gateway, sending in your credentials
            var gate = new Gateway(authorizeNetLogin, authorizeNetTransactionKey, isTest);

            //step 3 - make some money
            var response = gate.Send(request);

            
            pR = populatePaymentResponse(response);
            return pR;
        }
        catch (Exception ex)
        {
            pR.Approved = false;
            pR.Message = "Unable to communicate with Authorize.Net. Please check the internet connection on the Server or Contact Authorize.Net to see if their service is having issues." + ex.Message;
            pR.ResponseCode = "3";
            return pR;
        }

    }

    /// <summary>
    /// The purpose of this method is to refund a transaction that has been previously Approved and Settled.
    /// If you are unsure if the transaction has been Settled, try to Void the transaction prior to Refunding the transaction.
    /// </summary>
    /// <param name="transactionID">The Transaction Id of the Approved transaction being refunded</param>
    /// <returns>
    /// The returned Payment Response object will contain the following information received from Authorize.Net
    /// Response: 1 - Approved, 2 - Declined
    /// TransactionID: The new Transaction ID of the Refund transaction
    /// </returns>
    public paymentResponse refundPayment(string transactionID, decimal transactionAmount, string transactionCreditCard)
    {
        //Step 1 - create the Void Request for the requested TransactionId
        new CardPresentVoid(transactionID);
        var myVoidRequest = new VoidRequest(transactionID);

        //step 2 - create the gateway, sending in your credentials
        var gate = new Gateway(authorizeNetLogin, authorizeNetTransactionKey, true);

        var response = gate.Send(myVoidRequest);

        if (response.Approved == false && response.ResponseCode == "") {
            //Step 1 - create the Void Request for the requested TransactionId
            new CardPresentCredit(transactionID);
            var myCreditRequest = new CreditRequest(transactionID, transactionAmount, transactionCreditCard);

            response = gate.Send(myCreditRequest);
        }
        paymentResponse pR = new paymentResponse();
        return pR;
    }

    /// <summary>
    /// The purpose of this method is to void a transaction that has not yet been settled.
    /// </summary>
    /// <param name="transID">The Transaction ID of the original approved transaction.</param>
    /// <returns>
    /// The returned Payment Response object will contain the following information received from Authorize.Net
    /// Response: 1 - Approved, 2 - Declined
    /// Message: A message explaining the result of the request
    /// TransactionID: The new Transaction ID of the Refund transaction
    /// </returns>
    public paymentResponse voidTransaction(string transactionID)
    {
        //Step 1 - create the Void Request for the requested TransactionId
        var refund = new AuthorizeNet.VoidRequest(transactionID);

        //step 2 - create the gateway, sending in your credentials
        var gate = new Gateway(authorizeNetLogin, authorizeNetTransactionKey, true);

        var response = gate.Send(refund);

        paymentResponse pR = new paymentResponse();
        pR = populatePaymentResponse(response);
        return pR;
    }

    /// <summary>
    /// The purpose of this method is to populate the most common fields contained in a IGatewayResponse into the paymentRespons object
    /// </summary>
    /// <param name="IGR">
    /// Accepts the IGatewayResponse object received from AuthorizeNet.Gateway.Send command as Input
    /// </param>
    /// <returns>
    /// Returns a fully populated paymentResponse object
    /// </returns>
    public paymentResponse populatePaymentResponse(IGatewayResponse IGR)
    {
        paymentResponse pR = new paymentResponse();
        pR.Approved = IGR.Approved;
        pR.ApprovedAmount = IGR.Amount;
        pR.AuthCode = IGR.AuthorizationCode;
        pR.CardNumber = IGR.CardNumber;
        pR.InvoiceNumber = IGR.InvoiceNumber;
        pR.Message = IGR.Message;
        pR.ResponseCode = IGR.ResponseCode;
        pR.TransactionID = IGR.TransactionID;
        return pR;
    }

    public paymentResponse sendRequest(String CCNumber, String CCExpCd, String CCType, String Amount, String ServiceName, String TestModeIndicator, devoteeInfo DI)
    {
        // By default, this sample code is designed to post to our test server for
        // developer accounts: https://test.authorize.net/gateway/transact.dll
        // for real accounts (even in test mode), please make sure that you are
        // posting to: https://secure.authorize.net/gateway/transact.dll
        String post_url = "https://test.authorize.net/gateway/transact.dll";

        Dictionary<string, string> post_values = new Dictionary<string, string>();
        //the API Login ID and Transaction Key must be replaced with valid values
        post_values.Add("x_login", ConfigurationManager.AppSettings["AuthorizeNetLogin"]);
        post_values.Add("x_tran_key", ConfigurationManager.AppSettings["AuthorizeNetTransactionKey"]);
        post_values.Add("x_delim_data", "TRUE");
        post_values.Add("x_delim_char", "|");
        post_values.Add("x_relay_response", "FALSE");
        post_values.Add("x_market_type", "2");

        post_values.Add("x_device_type", "8");
        post_values.Add("x_test_request", TestModeIndicator);

        post_values.Add("x_type", "AUTH_CAPTURE");
        post_values.Add("x_method", "CC");
        post_values.Add("x_card_type", CCType);
        post_values.Add("x_card_num", CCNumber);
        post_values.Add("x_exp_date", CCExpCd);

        post_values.Add("x_amount", Amount);
        post_values.Add("x_description", ServiceName);

        post_values.Add("x_first_name", DI.firstName);
        post_values.Add("x_last_name", DI.lastName);
        post_values.Add("x_address", (DI.address1 + " " + DI.address2).Trim());
        post_values.Add("x_city", DI.city);
        post_values.Add("x_state", DI.state);
        post_values.Add("x_zip", DI.zip);
        post_values.Add("x_email", DI.email);


        post_values.Add("x_response_format", "0");
        post_values.Add("x_duplicate_window", "0");
        // Additional fields can be added here as outlined in the AIM integration
        // guide at: http://developer.authorize.net

        // This section takes the input fields and converts them to the proper format
        // for an http post.  For example: "x_login=username&x_tran_key=a1B2c3D4"
        String post_string = "";

        foreach (KeyValuePair<string, string> post_value in post_values)
        {
            post_string += post_value.Key + "=" + HttpUtility.UrlEncode(post_value.Value) + "&";
        }
        post_string = post_string.TrimEnd('&');

        // The following section provides an example of how to add line item details to
        // the post string.  Because line items may consist of multiple values with the
        // same key/name, they cannot be simply added into the above array.
        //
        // This section is commented out by default.
        /*
        string[] line_items = {
            "item1<|>golf balls<|><|>2<|>18.95<|>Y",
            "item2<|>golf bag<|>Wilson golf carry bag, red<|>1<|>39.99<|>Y",
            "item3<|>book<|>Golf for Dummies<|>1<|>21.99<|>Y"};
	
        foreach( string value in line_items )
        {
            post_string += "&x_line_item=" + HttpUtility.UrlEncode(value);
        }
        */

        // create an HttpWebRequest object to communicate with Authorize.net
        HttpWebRequest objRequest = (HttpWebRequest)WebRequest.Create(post_url);
        objRequest.Method = "POST";
        objRequest.ContentLength = post_string.Length;
        objRequest.ContentType = "application/x-www-form-urlencoded";

        // post data is sent as a stream
        StreamWriter myWriter = null;
        myWriter = new StreamWriter(objRequest.GetRequestStream());
        myWriter.Write(post_string);
        myWriter.Close();

        // returned values are returned as a stream, then read into a string
        String post_response;
        HttpWebResponse objResponse = (HttpWebResponse)objRequest.GetResponse();
        using (StreamReader responseStream = new StreamReader(objResponse.GetResponseStream()))
        {
            post_response = responseStream.ReadToEnd();
            responseStream.Close();
        }

        XDocument doc = XDocument.Parse(post_response);
        XElement xe = doc.XPathSelectElement("/response/ResponseCode");
        String response = xe.Value;
        paymentResponse pr = new paymentResponse();
        //pR.Approved = response;

        switch (response)
        {
            case "1":

                xe = doc.XPathSelectElement("/response/AuthCode");
                string authCode = xe.Value;
                //pr.authCode = xe.Value;
                xe = doc.XPathSelectElement("/response/TransID");
                string transID = xe.Value;
                //pr.transId = xe.Value;
                return pr;
            case "2":
                return pr;
            case "3":
                return pr;
            default:
                return pr;
        }

        //To implement...
        /* 
         * If response = 1 Approve. Insert into DB
         * If response = 2 Reject. Read Errors and display message
         * If response = 3 Error. Read Errors and display message
         */

        // the response string is broken into an array
        // The split character specified here must match the delimiting character specified above
        //Array response_array = post_response.Split('|');

        //// the results are output to the screen in the form of an html numbered list.
        //resultSpan.InnerHtml += "<OL> \n";
        //foreach (string value in response_array)
        //{
        //    resultSpan.InnerHtml += "<LI>" + value + "&nbsp;</LI> \n";
        //}
        //resultSpan.InnerHtml += "</OL> \n";
        //// individual elements of the array could be accessed to read certain response
        // fields.  For example, response_array[0] would return the Response Code,
        // response_array[2] would return the Response Reason Code.
        // for a list of response fields, please review the AIM Implementation Guide
    }

}