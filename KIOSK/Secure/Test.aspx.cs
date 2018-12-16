using CommonDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Data _data = new Data();
        List<ServiceDTO> _services = _data.GetServices();

        OrderedData od = new OrderedData();
        od.DevoteeId = 15;
        od.paymentMethodName = "CREDIT CARD";
        //od.orderTotal = new decimal(20);
        //od.orderItemCount = 4;

        od.cardName = "Vamsi Pulavarthi";
        od.cardNumber = CreditCardValidator.CreditCardFactory.RandomCardNumber(CreditCardValidator.CardIssuer.Visa);
        od.cardCVV2 = "999";
        od.cardExpiration = "0822";

        od.orderCreatedBy = "Vamsi";

        CartItems ci = new CartItems();
        List<CartItems> cl = new List<CartItems>(); 
        ci.CartId = "ABCD";
        ci.comment = "";
        ci.dateCreated = DateTime.Now.ToShortDateString();
        ci.ItemId = "ABCD";
        ci.orderDate = DateTime.Now.ToShortDateString();
        ci.Quantity = 4;
        ci.Service = _services.Where(s => s.Service_ID == 181).FirstOrDefault();
        ci.Service_ID = 181;
        cl.Add(ci);

        CartItems ci2 = new CartItems();
        ci2.CartId = "ABCDE";
        ci2.comment = "";
        ci2.dateCreated = DateTime.Now.ToShortDateString();
        ci2.ItemId = "ABCDE";
        ci2.orderDate = DateTime.Now.ToShortDateString();
        ci2.Quantity = 1;
        ci2.Service = _services.Where(s => s.Service_ID == 182).FirstOrDefault();
        ci2.Service_ID = 182;
        cl.Add(ci2);

        od.CartList = cl;
        od.orderItemCount = cl.Sum(item => item.Quantity);
        od.orderTotal = cl.Sum(item => item.Quantity * item.Service.Service_Fee);

        orderServices ms = new orderServices();
        ms.processNewOrder(od);
    }
}