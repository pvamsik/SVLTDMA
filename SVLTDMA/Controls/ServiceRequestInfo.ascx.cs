using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using CommonDTO;

public partial class Controls_ServiceRequestInfo : BaseControl
{

    public List<ServiceRequestDTO> serviceRequests;

    public int Devotee_ID { get; set; }
    public int Service_Request_ID { get; set; }

    protected override void Render(HtmlTextWriter p_oWriter)
    {

        serviceRequests = data.GetServiceRequests(Service_Request_ID, Devotee_ID);

        StringBuilder sb = new StringBuilder();
        StringWriter sw = new StringWriter(sb);
        HtmlTextWriter hw = new HtmlTextWriter(sw);

        rptrServiceRequests.DataSource = serviceRequests;
        rptrServiceRequests.DataBind();

        rptrServiceRequests.RenderControl(hw);
        p_oWriter.Write(sw.ToString());
    }

    protected void rptrServiceRequests_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            ServiceRequestDTO s = (ServiceRequestDTO)e.Item.DataItem;

            if (s.Transactions.Any())
            {
                HtmlGenericControl div = (HtmlGenericControl)e.Item.FindControl("requesttransactions");
                div.InnerHtml = gridRequestTransactions(s.Transactions);
            }
        }
    }

    protected string gridRequestTransactions(List<ServiceRequestTransactionDTO> transactions)
    {
        gvRequestTransactions.DataSource = transactions;
        gvRequestTransactions.DataBind();


        StringBuilder sb = new StringBuilder();
        StringWriter sw = new StringWriter(sb);
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        gvRequestTransactions.RenderControl(hw);

        return sb.ToString();
    }

    protected void gvRequestTransactions_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DateTime dt = Convert.ToDateTime(e.Row.Cells[3].Text);

            bool canVoid = false;
            bool canRefund = false;

            if (dt.Date.ToShortDateString() == DateTime.Today.Date.ToShortDateString())
                canVoid = (dt.Date <= DateTime.Today.AddHours(10).AddMinutes(30).AddSeconds(0));
            else
                canRefund = (dt.Date.AddDays(10) >= DateTime.Now);
            if (canVoid)
                e.Row.Cells[5].Text = "<a href=\"\" class=\"\">Void</>";
            else if (canRefund)
                e.Row.Cells[5].Text = "<a href=\"\" class=\"\">Refund</>";
            else
                e.Row.Cells[5].Text = "";
        }

    }
}