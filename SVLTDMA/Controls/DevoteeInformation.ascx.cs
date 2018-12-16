using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_DevoteeInformation : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void cmdEditDevoteeInfo_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/devotee/editDevotee.aspx?devoteeId=" + (String)Request.QueryString["devoteeId"]);
    }

    protected void cmdBacktoSearch_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/");
    }

    protected void cmdOrdersList_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/devotee/ordersList.aspx?devoteeId=" + Request.QueryString["devoteeId"]);
    }

    protected void cmdNewOrder_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/devotee/createOrder.aspx#?devoteeId=" + Request.QueryString["devoteeId"]);
    }
}