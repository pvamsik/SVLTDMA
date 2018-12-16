<%@ Page Title="Manage Profile" Language="C#" Theme="kiosk" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="ManageProfile.aspx.cs" Inherits="Account_ManageProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ChangePassword ID="siteChangePassword" runat="server" DisplayUserName="True" RenderOuterTable="False" SuccessPageUrl="~/Default.aspx" CancelDestinationPageUrl="~/Default.aspx">
        <ChangePasswordTemplate>
            <div class="form-horizontal">
                <fieldset>
                    <legend>Change your Password</legend>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                            <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="siteChangePassword">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Password:</asp:Label>
                            <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="siteChangePassword">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">New Password:</asp:Label>
                            <asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" ErrorMessage="New Password is required." ToolTip="New Password is required." ValidationGroup="siteChangePassword">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label>
                            <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required." ValidationGroup="siteChangePassword">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry." ValidationGroup="siteChangePassword"></asp:CompareValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-12">
                            <asp:Button ID="ChangePasswordPushButton" runat="server" CssClass="btn btn-primary" CommandName="ChangePassword" Text="Change Password" ValidationGroup="siteChangePassword" />
                            <asp:Button ID="CancelPushButton" runat="server" CssClass="btn btn-default" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </div>
                    </div>
                </fieldset>
            </div>
        </ChangePasswordTemplate>
    </asp:ChangePassword>
</asp:Content>

