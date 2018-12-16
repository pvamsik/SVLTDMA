<%@ Page Title="Recover Password" Language="C#" MasterPageFile="~/admin.master" Theme="Admin" AutoEventWireup="true" CodeFile="forgotPassword.aspx.cs" Inherits="forgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" SuccessPageUrl="~/Account/Login.aspx" CssClass="col-lg-6">
            <MailDefinition BodyFileName="~/assets/userForgotPasswordEmail.html" CC="receipts@svlotustemple.org" From="receipts@svlotustemple.org" IsBodyHtml="True" Priority="High" Subject="Reset Password">
            </MailDefinition>
            <TextBoxStyle />
            <UserNameTemplate>
                <div class="form-horizontal">
                    <fieldset>
                        <legend>Forgot Your Password?</legend>
                        <div class="form-group">
                            <div class="col-lg-4"></div>
                            <div class="col-lg-8">
                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-4"></div>
                            <div class="col-lg-8">
                                Enter your User Name to receive your password.
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="col-lg-4 control-label">User Name:</asp:Label>
                            <div class="col-lg-8">
                                <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-12 text-center">
                                <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Submit" ValidationGroup="PasswordRecovery1" CssClass="btn btn-primary" />
                                <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Account/Login.aspx" CssClass="btn btn-default">Go back to login page...</asp:LinkButton>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </UserNameTemplate>
        </asp:PasswordRecovery>
</asp:Content>

