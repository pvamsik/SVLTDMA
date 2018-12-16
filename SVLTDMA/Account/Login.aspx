<%@ Page Title="Login Page" Language="C#" MasterPageFile="~/admin.master" Theme="Admin" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Login ID="siteLogin" runat="server"
        DestinationPageUrl="~/Default.aspx" OnAuthenticate="siteLogin_Authenticate" PasswordRecoveryUrl="~/Account/forgotPassword.aspx"
        PasswordRecoveryText="Forgot Password?"
        OnLoggedIn="siteLogin_LoggedIn" CssClass="col-lg-6">
        <LayoutTemplate>
            <div class="form-horizontal">
                <fieldset>
                    <legend>Log In</legend>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="UserNameLabel" runat="server" CssClass="col-lg-4 control-label" AssociatedControlID="UserName">User Name:</asp:Label>
                        <div class="col-lg-8">
                            <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="siteLogin">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="PasswordLabel" runat="server" CssClass="col-lg-4 control-label" AssociatedControlID="Password">Password:</asp:Label>
                        <div class="col-lg-8">
                            <asp:TextBox ID="Password" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="siteLogin">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-4"></div>
                        <div class="col-lg-8">
                            <div class="checkbox">
                                <label>
                                    <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me." />
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12 text-center">
                            <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="siteLogin" CssClass="btn btn-primary text-left" />
                            <asp:HyperLink ID="PasswordRecoveryLink" runat="server" NavigateUrl="~/Account/forgotPassword.aspx" CssClass="btn btn-default">Forgot Password?</asp:HyperLink>
                        </div>
                    </div>
                </fieldset>
            </div>
        </LayoutTemplate>
    </asp:Login>
</asp:Content>