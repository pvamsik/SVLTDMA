using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.Profile;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Text;
using System.IO;

public partial class Controls_createUser : System.Web.UI.UserControl
{
    Data data;
    public List<RolesDTO> AvailableRoles;
    protected void Page_Load(object sender, EventArgs e)
    {
        data = new Data();
        if (!IsPostBack)
        {
            AvailableRoles = data.GetRoles(Roles.GetRolesForUser(Page.User.Identity.Name).FirstOrDefault());
        }

    }
    protected void CreateUser_CreatedUser(object sender, EventArgs e)
    {
        lblError.Visible = false;

        RadioButtonList rblRole = (RadioButtonList)CreateUser.CreateUserStep.ContentTemplateContainer.FindControl("rblRoleList");
        Roles.AddUserToRole(CreateUser.UserName, rblRole.SelectedValue);

        // Create an empty Profile for the newly created user

        ProfileCommon p = (ProfileCommon)ProfileCommon.Create(CreateUser.UserName, true);

        // Populate some Profile properties off of the create user wizard
        p.Name = ((TextBox)CreateUser.CreateUserStep.ContentTemplateContainer.FindControl("Name")).Text;
        p.PhoneNumber1 = ((TextBox)CreateUser.CreateUserStep.ContentTemplateContainer.FindControl("PhoneNumber1")).Text;
        p.PhoneNumber2 = ((TextBox)CreateUser.CreateUserStep.ContentTemplateContainer.FindControl("PhoneNumber2")).Text;

        // Save profile - must be done since we explicitly created it
        p.Save();

        //Fill out the template information for New User Creation Email.
        string body = string.Empty;
        using (StreamReader reader = new StreamReader(Server.MapPath("~/assets/userCreatedEmail.html")))
        {
            body = reader.ReadToEnd();
        }
        body = body.Replace("{UserFullName}", ((TextBox)CreateUser.CreateUserStep.ContentTemplateContainer.FindControl("Name")).Text);
        body = body.Replace("{UserName}", ((TextBox)CreateUser.CreateUserStep.ContentTemplateContainer.FindControl("UserName")).Text);
        body = body.Replace("{Password}", ((TextBox)CreateUser.CreateUserStep.ContentTemplateContainer.FindControl("Password")).Text);
        
        //Create a ne Email Provider Object to Send out email.
        EmailProvider ep = new EmailProvider();
        List<string> receivers = new List<string>();
        receivers.Add("receipts@svlotustemple.org");
        string res = ep.sendEmail("New User Login Registration", body, ((TextBox)CreateUser.CreateUserStep.ContentTemplateContainer.FindControl("Email")).Text, receivers);
        if (res == "Success")
        {
            //Reload the page when the User has been created and email has been sent.
            //lblError.Text = "Successfully Created User";
            //lblError.Visible = true;
        }
        else
        {
            //Display the Error message on why the email was not sent.
            lblError.Text = res;
            lblError.Visible = true;
        }
    }

    protected void CreateUser_Load(object sender, EventArgs e)
    {
        RadioButtonList rbl = (RadioButtonList)CreateUser.CreateUserStep.ContentTemplateContainer.FindControl("rblRoleList");
        rbl.DataSource = AvailableRoles;
        rbl.DataBind();        
    }
    protected void ContinueButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.UrlReferrer.ToString());
    }
}