<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/admin.master" Theme="Admin" AutoEventWireup="true" CodeFile="manageProfile.aspx.cs" Inherits="manageProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ChangePassword ID="ChangePassword1" runat="server"
        CancelDestinationPageUrl="~/Default.aspx" SuccessPageUrl="~/Default.aspx" PasswordLabelText="Old Password:" CssClass="col-lg-6">
        <ChangePasswordTemplate>
            <div class="form-horizontal">
                <fieldset>
                    <legend>Change Your Password</legend>
                    <div class="form-group">
                        <div class="col-lg-4"></div>
                        <div class="col-lg-8">
                            <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry." ValidationGroup="ChangePassword1"></asp:CompareValidator>
                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword" CssClass="control-label col-lg-4">Old Password:</asp:Label>
                        <div class="col-lg-8">
                            <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword" CssClass="control-label col-lg-4">New Password:</asp:Label>
                        <div class="col-lg-8">
                            <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" ErrorMessage="New Password is required." ToolTip="New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword" CssClass="control-label col-lg-4">Confirm New Password:</asp:Label>
                        <div class="col-lg-8">
                            <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12 text-center">
                            <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword" Text="Change Password" ValidationGroup="ChangePassword1" CssClass="btn btn-primary" />
                            <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                        </div>
                    </div>
                </fieldset>
            </div>
        </ChangePasswordTemplate>
    </asp:ChangePassword>
</asp:Content>

