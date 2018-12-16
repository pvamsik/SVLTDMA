using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class devotee_editdevotee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DataView dv = (DataView)DevoteeInfo.Select(DataSourceSelectArguments.Empty);
            if (dv != null)
            {
                DataRowView row = dv[0];
                //Prefill Name information
                ddlTitle.SelectedValue = row["dtitle"].ToString();
                txtFName.Text = row["dfname"].ToString();
                txtMName.Text = row["dmname"].ToString();
                txtLName.Text = row["dlname"].ToString();

                //Prefill Address Information
                txtAddress1.Text = row["daddress1"].ToString();
                txtAddress2.Text = row["daddress2"].ToString();
                txtCity.Text = row["dcity"].ToString();
                ddlState.SelectedValue = row["dstate"].ToString();
                txtZip.Text = row["dzip"].ToString();

                //Prefill Contact Information
                txtPhone1.Text = row["dphone1"].ToString();
                txtPhone2.Text = row["dphone2"].ToString();
                txtEmail1.Text = row["demail1"].ToString();
                txtEmail2.Text = row["demail2"].ToString();
            }
        }
    }
    protected void cmdUpdateDevotee_Click(object sender, EventArgs e)
    {
        if( Request.QueryString["devoteeId"] != "" )
        {
            if( ddlState.SelectedIndex != 0 ) 
            {
                //Set the Devotee ID from  QueryString
                DevoteeInfo.UpdateParameters["did"].DefaultValue = Request.QueryString["devoteeId"];


                //Process Name Information
                //Process Title
                if (ddlTitle.SelectedIndex > 0)
                {
                    DevoteeInfo.UpdateParameters["dtitle"].DefaultValue = ddlTitle.SelectedValue;
                }

                //Process Name
                DevoteeInfo.UpdateParameters["dfname"].DefaultValue = txtFName.Text;
                if (txtMName.Text != "")
                {
                    DevoteeInfo.UpdateParameters["dmname"].DefaultValue = txtMName.Text;
                }
                DevoteeInfo.UpdateParameters["dlname"].DefaultValue = txtLName.Text;

                //Process Address Information
                DevoteeInfo.UpdateParameters["daddress1"].DefaultValue = txtAddress1.Text;
                if (txtAddress2.Text != "")
                {
                    DevoteeInfo.UpdateParameters["daddress2"].DefaultValue = txtAddress2.Text;
                }
                DevoteeInfo.UpdateParameters["dcity"].DefaultValue = txtCity.Text;
                DevoteeInfo.UpdateParameters["dstate"].DefaultValue = ddlState.SelectedValue;
                DevoteeInfo.UpdateParameters["dzip"].DefaultValue = txtZip.Text;

                //Process Contact Information
                DevoteeInfo.UpdateParameters["dphone1"].DefaultValue = txtPhone1.Text;
                if (txtPhone2.Text != "")
                {
                    DevoteeInfo.UpdateParameters["dphone2"].DefaultValue = txtPhone2.Text;
                }
                DevoteeInfo.UpdateParameters["demail1"].DefaultValue = txtEmail1.Text;
                if (txtEmail2.Text != "")
                {
                    DevoteeInfo.UpdateParameters["demail2"].DefaultValue = txtEmail2.Text;
                }

                //Update Devotee Information
                try
                {
                    int result = DevoteeInfo.Update();
                    if (result == -1)
                    {
                        lblErrorMsg.Text = "Success!";
                        lblErrorMsg.Visible = true;
                        Response.Redirect("~/devotee/newOrder.aspx?devoteeId=" + (String)Request.QueryString["devoteeId"]);
                    }
                    else
                    {
                        lblErrorMsg.Text = "Failed!";
                        lblErrorMsg.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    lblErrorMsg.Text = ex.Message;
                    lblErrorMsg.Visible = true;
                }
            }
            else
            {
                lblErrorMsg.Text = "Please select a state!";
                lblErrorMsg.Visible = true;
            }
        }
        else
        {
            lblErrorMsg.Text = "No Devotee Selected. Please go back to Search and start over!";
            lblErrorMsg.Visible = true;
        }
    }
    protected void cmdCancelEdit_Click(object sender, EventArgs e)
    {
        string urlReferer = Request.UrlReferrer.ToString();

        if(!string.IsNullOrEmpty(urlReferer))
        {
            Response.Redirect( urlReferer );
        }
        else
        {
            Response.Redirect("~/devotee/searchDevotee.aspx");
        }
    }
}