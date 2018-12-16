<%@ Page Title="SVLT Food Sales" Language="C#" Theme="kiosk" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Login ID="loginForm" runat="server" DestinationPageUrl="~/Secure/Kiosk.aspx" RenderOuterTable="False" VisibleWhenLoggedIn="False">
        <LayoutTemplate>
            <div class="form-horizontal">
                <fieldset>
                    <legend>Login</legend>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="control-label">User Name:</asp:Label>
                            <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="loginForm">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                            <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." 
                                ValidationGroup="loginForm">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <div class="checkbox">
                                <label>
                                    <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me next time." />
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="loginForm" runat="server" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:Button ID="LoginButton" runat="server" CommandName="Login" CssClass="btn btn-primary" Text="Log In" ValidationGroup="loginForm" />
                        </div>
                    </div>
                </fieldset>
            </div>
        </LayoutTemplate>
    </asp:Login>
</asp:Content>

