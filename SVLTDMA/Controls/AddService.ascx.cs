using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Controls_AddService : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void cmdCreate_Click(object sender, EventArgs e)
    {
        sdsInsertService.InsertParameters["serviceName"].DefaultValue = txtServiceName.Text;
        sdsInsertService.InsertParameters["serviceDescription"].DefaultValue = txtServiceDescription.Text;
        sdsInsertService.InsertParameters["serviceFee"].DefaultValue = txtServiceFee.Text;
        sdsInsertService.InsertParameters["serviceTypeID"].DefaultValue = rblServiceLocation.SelectedValue;
        sdsInsertService.InsertParameters.Add("isPriceEditable", (chkPriceEditable.Checked).ToString());

        try
        {
            int result = sdsInsertService.Insert();
        }
        catch (Exception ex)
        {
            messages.Text = ex.Message;
        }
    }
    protected void sdsInsertService_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        switch (e.Command.Parameters["@result"].Value.ToString())
	    {
            case "0":
                messages.Text = "Service Created Successfully!!!";
                ViewState["Services"] = null;
                break;
            case "100":
                messages.Text = "Service exists in the database";
                break;
		    default:
                messages.Text = "Unkwown Error has occured";
                break;
	    }
    }
}