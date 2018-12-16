using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Controls_manageUsers : System.Web.UI.UserControl
{
    private Data data;
    public List<ManageableUsersDTO> ManageableUsers;
    public List<RolesDTO> AvailableRoles {
        get
        {
            if (ViewState["AvailableRoles"] == null)
            {
                data = new Data();
                ViewState["AvailableRoles"] = data.GetRoles(Roles.GetRolesForUser(Page.User.Identity.Name).FirstOrDefault());
            }
            return (List<RolesDTO>)ViewState["AvailableRoles"];
        } 
        set{
            ViewState["AvailableRoles"] = value;
        } 
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        data = new Data();
        if (!IsPostBack)
        {
            ManageableUsers = data.GetManageableUsers(Roles.GetRolesForUser(Page.User.Identity.Name).FirstOrDefault());
            //AvailableRoles = //data.GetRoles(Roles.GetRolesForUser(Page.User.Identity.Name).FirstOrDefault());
            GridView1.DataSource = ManageableUsers;
            GridView1.DataBind();
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GridView1.SelectedRow;

        string loggedinUser = Page.User.Identity.Name.ToLower();
        string userName = row.Cells[3].Text.ToLower();
        string userNameRole = Roles.GetRolesForUser(userName).FirstOrDefault();
        if (userName != "")
        {
            if (loggedinUser != userName)
            {
                lblError.Visible = false;
                ProfileCommon pc = (ProfileCommon)Profile.GetProfile(userName);
                MembershipUser currentUser = Membership.GetUser(userName);
                rblRoleList.DataSource = AvailableRoles;
                rblRoleList.DataBind();
                rblRoleList.SelectedValue = userNameRole;
                lblUserName.Text = userName;
                txtFullName.Text = pc.Name;
                txtPhone1.Text = pc.PhoneNumber1;
                txtPhone2.Text = pc.PhoneNumber2;
                txtEmail.Text = currentUser.Email;
                chkApproved.Checked = currentUser.IsApproved;
                manageUser.Visible = true;
            }
            else
            {
                manageUser.Visible = false;
                lblError.Visible = true;
                lblError.Text = "You are not allowed to manage your own profile. Please have another Admin update your profile.";
            }
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {

        }
        if (e.CommandName == "Unlock")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[index];
            string userName = row.Cells[3].Text.ToLower();
            if (userName != "")
            {
                MembershipUser u = Membership.GetUser(userName);
                if (u != null)
                {
                    try
                    {
                        if (u.UnlockUser())
                        {
                            Response.Redirect(Request.UrlReferrer.ToString());
                        }
                        else
                        {
                            lblMessage.Text = "Unable to Unlock user. Please reach out to an Administrator";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = ex.Message;
                        return;
                    }
                }
            }

        }
        if (e.CommandName == "Reset")
        {
            string newPassword = "";

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[index];

            string userName = row.Cells[3].Text.ToLower();
            if (userName != "")
            {
                MembershipUser u = Membership.GetUser(userName);
                if (u != null)
                {
                    try
                    {
                        newPassword = u.ResetPassword();
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = ex.Message;
                        return;
                    }

                }

                if (newPassword != null)
                {
                    //Fill out the template information for New User Creation Email.
                    string body = string.Empty;
                    using (StreamReader reader = new StreamReader(Server.MapPath("~/assets/userCreatedEmail.html")))
                    {
                        body = reader.ReadToEnd();
                    }
                    body = body.Replace("{UserFullName}", userName);
                    body = body.Replace("{UserName}", userName);
                    body = body.Replace("{Password}", newPassword);

                    //Create a ne Email Provider Object to Send out email.
                    EmailProvider ep = new EmailProvider();
                    List<string> receivers = new List<string>();
                    receivers.Add("receipts@svlotustemple.org");
                    string res = ep.sendEmail("New User Login Registration", body, row.Cells[5].Text.ToLower(), receivers);
                    if (res == "Success")
                    {
                        //Reload the page when the User has been created and email has been sent.
                        Response.Redirect(Request.UrlReferrer.ToString());
                    }
                    else
                    {
                        //Display the Error message on why the email was not sent.
                        lblMessage.Text = res;
                    }
                    lblMessage.Text = "Password reset. Your new password is: " + Server.HtmlEncode(newPassword);
                }
                else
                {
                    lblMessage.Text = "Password reset failed. Please re-enter your values and try again.";
                }
            }
        }
    }

    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        
        try
        {
            string userName = lblUserName.Text;
            string userNameRole = Roles.GetRolesForUser(userName).FirstOrDefault();
            ProfileCommon pc = (ProfileCommon)Profile.GetProfile(userName);
            MembershipUser currentUser = Membership.GetUser(userName);

            //Update profile information
            pc.Name = txtFullName.Text;
            pc.PhoneNumber1 = txtPhone1.Text;
            pc.PhoneNumber2 = txtPhone2.Text;
            pc.Save();

            //Update Membership information
            currentUser.Email = txtEmail.Text;
            currentUser.IsApproved = chkApproved.Checked;
            Membership.UpdateUser(currentUser);
            if (rblRoleList.SelectedValue != userNameRole)
            {
                Roles.RemoveUserFromRole(userName, userNameRole);
                Roles.AddUserToRole(userName, rblRoleList.SelectedValue);
            }
            lblError.Visible = false;
        }
        catch (Exception ex)
        {
            lblError.Visible = true;
            lblError.Text = ex.Message;
        }
        finally
        {
            manageUser.Visible = false;
        }
        Response.Redirect(Request.UrlReferrer.ToString());

    }
    protected void cmdCancel_Click(object sender, EventArgs e)
    {
        manageUser.Visible = false;
        lblError.Visible = false;
        Response.Redirect(Request.UrlReferrer.ToString());
    }
}