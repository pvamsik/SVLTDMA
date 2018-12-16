using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

/// <summary>
/// This Class contains all the information required to process and store an Order Submitted from the front end.
/// </summary>
public class OrderedData
{
    public int DevoteeId { get; set; }
    public string paymentMethodName { get; set; }
    public decimal orderTotal { get; set; }
    public int orderItemCount { get; set; }

    //CC Properties
    public string cardName { get; set; }
    public string cardNumber { get; set; }
    public string cardExpiration { get; set; }
    public string cardCVV2 { get; set; }

    //Check Properties
    public string checkDate { get; set; }
    public string checkNumber { get; set; }

    public string orderCreatedBy { get; set; }
    public string Comment1 { get; set; }
    public string Comment2 { get; set; }
    public string Comment3 { get; set; }
    public List<CartItems> CartList { get; set; }
}

[Serializable]
public class OrderResponse
{
    public int resultCode { get; set; }
    public string message { get; set; }
    public int? orderId { get; set; }
}

