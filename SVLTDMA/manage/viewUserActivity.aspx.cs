using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class manage_viewUserActivity : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            searchDateFrom.Text = DateTime.Now.AddDays(-7).ToShortDateString();
            searchDateTo.Text = DateTime.Now.AddDays(1).ToShortDateString();
        }
    }
    protected void cmdSearchUserActivity_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(searchDateFrom.Text))
        {
            sdsUserActivityByUser.SelectParameters[1].DefaultValue = (searchDateFrom.Text).Trim();
        }
        if (!string.IsNullOrEmpty(searchDateTo.Text))
        {
            sdsUserActivityByUser.SelectParameters[2].DefaultValue = (searchDateTo.Text).Trim();
        }
        sdsUserActivityByUser.Select(DataSourceSelectArguments.Empty);
        GridView1.DataSourceID = null;
        GridView1.DataSource = sdsUserActivityByUser;
        GridView1.DataBind();
    }
}