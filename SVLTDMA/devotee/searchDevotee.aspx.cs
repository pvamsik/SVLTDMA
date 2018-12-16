using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class devotee_searchDevotee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void cmdSearch_Click(object sender, EventArgs e)
    {
        AppLogger al = new AppLogger();
        string activity = "";
        activity = "Searched for: '" + txtFName.Text + "', '" + txtLName.Text + "', '" + txtPhone.Text + "'";
        al.LogActivity(Page.User.Identity.Name, activity, HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath);

        SqlDataSource1.SelectParameters[0].DefaultValue = "%";
        SqlDataSource1.SelectParameters[1].DefaultValue = "%";
        SqlDataSource1.SelectParameters[2].DefaultValue = "%";
        if ( !( string.IsNullOrEmpty(txtFName.Text) & string.IsNullOrEmpty(txtLName.Text) & string.IsNullOrEmpty(txtPhone.Text) && string.IsNullOrEmpty(txtUserId.Text) ) )
        {
            if (!string.IsNullOrEmpty(txtPhone.Text))
            {
                string str = txtPhone.Text;
                str = str.Replace(" ", "");
                str = str.Replace("(", "");
                str = str.Replace(")", "");
                str = str.Replace("-", "");
                str = str.Replace("%", "");
                SqlDataSource1.SelectParameters[0].DefaultValue = str;
            }
            if (!string.IsNullOrEmpty(txtFName.Text))
            {
                string str = txtFName.Text;
                str = str.Replace("%", "");
                str = str.Trim();
                SqlDataSource1.SelectParameters[1].DefaultValue = str;
            }
            if (!string.IsNullOrEmpty(txtLName.Text))
            {
                string str = txtLName.Text;
                str = str.Replace("%", "");
                str = str.Trim();
                SqlDataSource1.SelectParameters[2].DefaultValue = str;
            }
            if (!string.IsNullOrEmpty(txtUserId.Text))
            {
                string str = txtUserId.Text;
                str = str.Replace("%", "");
                str = str.Trim();
                SqlDataSource1.SelectParameters[3].DefaultValue = str;
            }
            SqlDataSource1.Select(DataSourceSelectArguments.Empty);

            GridView1.DataSourceID = null;
            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();
            lblError.Visible = false;
        }
        else
        {
            lblError.Visible = true;
        }
    }
    protected void cmdCancel_Click(object sender, EventArgs e)
    {
        txtFName.Text = "";
        txtLName.Text = "";
        txtPhone.Text = "";
        GridView1.DataSource = null;
        GridView1.DataBind();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = 0;
        switch (e.CommandName)
        {
            case "List":
                index = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("~/devotee/requestsList.aspx?devoteeId=" + GridView1.DataKeys[index].Value.ToString());
                break;
            case "Edit":
                index = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("~/devotee/editDevotee.aspx?devoteeId=" + GridView1.DataKeys[index].Value.ToString());
                break;
            default:
                index = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("~/devotee/createOrder.aspx#?devoteeId=" + GridView1.DataKeys[index].Value.ToString());
                break;
        }
    }
    //protected void cmdDuplicate_Click(object sender, EventArgs e)
    //{
    //    Boolean primarySelected = false;
    //    Boolean duplicateSelected = false;
    //    string primaryAccountId = "";
    //    foreach (GridViewRow row in GridView1.Rows)
    //    {
    //        DropDownList check = (DropDownList)row.FindControl("ddlDupUpdate");

    //        if (check.SelectedIndex == 1)
    //        {
    //            primarySelected = true;
    //            primaryAccountId = GridView1.DataKeys[row.RowIndex].Value.ToString();
    //        }
    //        if (check.SelectedIndex == 2)
    //        {
    //            duplicateSelected = true;
    //        }
    //    }

    //    if (primarySelected == true && duplicateSelected == true)
    //    {
    //        foreach (GridViewRow row in GridView1.Rows)
    //        {
    //            string m = GridView1.DataKeys[row.RowIndex].Value.ToString();
    //            DropDownList check = (DropDownList)row.FindControl("ddlDupUpdate");
    //            if (check.SelectedIndex == 2)
    //            {
    //                manageDuplicates.UpdateParameters["devoteeStatus"].DefaultValue = "1";
    //                manageDuplicates.UpdateParameters["devoteeId"].DefaultValue = m;
    //                manageDuplicates.Update();
    //            }
    //        }
    //    }

    //    Response.Redirect("~/devotee/devoteeServiceHistory.aspx?devoteeId=" + primaryAccountId);
    //}
    protected void cmdFamily_Click(object sender, EventArgs e)
    {
        Boolean primarySelected = false;
        Boolean duplicateSelected = false;
        string primaryAccountId = "";
        string secondaryAccountId = "";
        foreach (GridViewRow row in GridView1.Rows)
        {
            DropDownList check = (DropDownList)row.FindControl("ddlFamilyUpdate");
            if (check.SelectedIndex == 1)
            {
                primarySelected = true;
                primaryAccountId = GridView1.DataKeys[row.RowIndex].Value.ToString();
            }
            if (check.SelectedIndex >= 2)
            {
                duplicateSelected = true;
                secondaryAccountId = GridView1.DataKeys[row.RowIndex].Value.ToString();
            }
        }
        if (primarySelected == true && duplicateSelected == true)
        {
            //System.Windows.Forms.MessageBox.Show("Test", "This is a test", System.Windows.Forms.MessageBoxButtons.OK);
            foreach (GridViewRow row in GridView1.Rows)
            {
                //string m = GridView1.DataKeys[row.RowIndex].Value.ToString();
                DropDownList check = (DropDownList)row.FindControl("ddlFamilyUpdate");
                if (check.SelectedIndex >= 2)
                {
                    manageFamilyMembers.InsertParameters["primarydevoteeid"].DefaultValue = primaryAccountId;
                    manageFamilyMembers.InsertParameters["secondarydevoteeid"].DefaultValue = secondaryAccountId;
                    manageFamilyMembers.InsertParameters["relationid"].DefaultValue = check.SelectedItem.Value;

                    manageFamilyMembers.Insert();

                    //manageFamilyMembers.InsertParameters["devfmfname"].DefaultValue = ((Label)row.FindControl("Label1")).Text;
                    //manageFamilyMembers.InsertParameters["devfmlname"].DefaultValue = ((Label)row.FindControl("Label2")).Text;
                    //manageFamilyMembers.InsertParameters["devfmrelation"].DefaultValue = check.SelectedItem.Text;
                    //manageFamilyMembers.InsertParameters["devfmrelstatus"].DefaultValue = "0";
                    //manageFamilyMembers.InsertParameters["devmasterid"].DefaultValue = secondaryAccountId;
                    //manageFamilyMembers.InsertParameters["devId"].DefaultValue = primaryAccountId;
                    //manageFamilyMembers.Insert();

                    //manageDuplicates.UpdateParameters["devoteeStatus"].DefaultValue = "1";
                    //manageDuplicates.UpdateParameters["devoteeId"].DefaultValue = GridView1.DataKeys[row.RowIndex].Value.ToString();
                    //manageDuplicates.Update();
                }
            }
            Response.Redirect("~/default.aspx");
        }
        else
        {

        }


    }
    protected void txtCCSwipe_TextChanged(object sender, EventArgs e)
    {
        string string1;
        try
        {
            string1 = txtCCSwipe.Text;

            string[] ccparts;
            ccparts = string1.Split('^');

            
            string ccName = ccparts[1].Trim();

            if (ccName.IndexOf('/') > 0)
            {
                string[] names = ccName.Split('/');

                txtFName.Text = names[1];
                txtLName.Text = names[0];

                txtFName.Focus();
            }
            else
                txtCCSwipe.Focus();
            
            //txtFName.Text = ccName;
            txtCCSwipe.Text = "";
            
        }
        catch (Exception)
        {
            txtCCSwipe.Text = "Unable to read Credit Card";
            txtCCSwipe.Focus();
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            foreach (Control ctrl in e.Row.Cells[0].Controls)
            {
                if (ctrl.GetType().BaseType == typeof(ImageButton))
                    ((ImageButton)ctrl).ToolTip = ((ImageButton)ctrl).AlternateText;
            }
            foreach (Control ctrl in e.Row.Cells[1].Controls)
            {
                if (ctrl.GetType().BaseType == typeof(ImageButton))
                    ((ImageButton)ctrl).ToolTip = ((ImageButton)ctrl).AlternateText;
            }
            foreach (Control ctrl in e.Row.Cells[2].Controls)
            {
                if (ctrl.GetType().BaseType == typeof(ImageButton))
                    ((ImageButton)ctrl).ToolTip = ((ImageButton)ctrl).AlternateText;
            }

        }
    }
}