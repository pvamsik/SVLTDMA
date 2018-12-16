using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class devotee_createDevotee : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblErrorMsg.Visible = false;
        //txtFName.Text = "Vamsi";
        //txtMName.Text = "K";
        //txtLName.Text = "Pulavarthi";
        //txtAddress1.Text = "3203 Arrowhead Circle";
        //txtAddress2.Text = "Apt K";
        //txtCity.Text = "Fax";
        //txtZip.Text = "2230";
        //txtEmail1.Text = "pvamsik_in@yahoo.com";
        //txtPhone1.Text = "7039551520";
        //ddlState.SelectedValue = "MD";
    }
    protected void cmdCreateDevotee_Click(object sender, EventArgs e)
    {

        if (ddlTitle.SelectedIndex > 0)
        {
            sqlDSCreateDevotee.InsertParameters["dTitle"].DefaultValue = ddlTitle.SelectedValue;
        }
        sqlDSCreateDevotee.InsertParameters["dLastName"].DefaultValue = txtLName.Text;
        sqlDSCreateDevotee.InsertParameters["dFirstName"].DefaultValue = txtFName.Text;
        if (txtMName.Text != "")
        {
            sqlDSCreateDevotee.InsertParameters["dMiddleName"].DefaultValue = txtMName.Text;
        }


        sqlDSCreateDevotee.InsertParameters["dAddress1"].DefaultValue = txtAddress1.Text;
        if (txtAddress2.Text != "")
        {
            sqlDSCreateDevotee.InsertParameters["dAddress2"].DefaultValue = txtAddress2.Text;
        }
        sqlDSCreateDevotee.InsertParameters["dCity"].DefaultValue = txtCity.Text;
        sqlDSCreateDevotee.InsertParameters["dState"].DefaultValue = ddlState.SelectedValue;
        sqlDSCreateDevotee.InsertParameters["dZip"].DefaultValue = txtZip.Text;

        sqlDSCreateDevotee.InsertParameters["dEmail1"].DefaultValue = txtEmail1.Text;
        if (txtEmail2.Text != "")
        {
            sqlDSCreateDevotee.InsertParameters["dEmail2"].DefaultValue = txtEmail2.Text;
        }

        sqlDSCreateDevotee.InsertParameters["dPhone1"].DefaultValue = txtPhone1.Text;
        if (txtPhone2.Text != "")
        {
            sqlDSCreateDevotee.InsertParameters["dPhone2"].DefaultValue = txtPhone2.Text;
        } 

        try
        {
            int result = sqlDSCreateDevotee.Insert();
            if (result == -1) {
                if (sqlDSCreateDevotee.InsertParameters["dResult"].DefaultValue == "0")
                {
                    Int32 devoteeID = Convert.ToInt32(sqlDSCreateDevotee.InsertParameters["dMessage"].DefaultValue);
                    Response.Redirect("~/devotee/newOrder.aspx?devoteeID=" + devoteeID);
                }
                else
                {
                    lblErrorMsg.Text = "Devotee Exists Already. Please use the Home page to search for the Devotee again.";
                    lblErrorMsg.Visible = true;
                }
            }
        }
        catch (Exception ex)
        {
            lblErrorMsg.Text = ex.Message;
            lblErrorMsg.Visible = true;
        }
    }

    protected void sqlDSCreateDevotee_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        System.Data.Common.DbCommand command = e.Command;
        sqlDSCreateDevotee.InsertParameters["dMessage"].DefaultValue = command.Parameters["@dMessage"].Value.ToString();
        sqlDSCreateDevotee.InsertParameters["dResult"].DefaultValue = command.Parameters["@dResult"].Value.ToString();
    }
}