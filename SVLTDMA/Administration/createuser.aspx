<%@ Page Title="Create User" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="createuser.aspx.cs" Inherits="manage_createuser" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Controls/createUser.ascx" TagPrefix="uc1" TagName="createUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel runat="server" ID="pnlCreateUser" CssClass="panel panel-default">
        <div class="panel-heading">Create User</div>
        <div class="panel-body form-horizontal">

            <div class="form-group">
                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
            </div>
            <div class="form-group">
                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" SkinID="frmLabel">User Name</asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="UserName" runat="server" class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="NameLabel" runat="server" AssociatedControlID="Name" SkinID="frmLabel">Name</asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="Name" runat="server" class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Name" ErrorMessage="Name is required." ToolTip="Name is required." ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="PhoneNumber1Label" runat="server" AssociatedControlID="PhoneNumber1" SkinID="frmLabel">Phone Number 1</asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="PhoneNumber1" runat="server" class="form-control"></asp:TextBox>
                    <asp:FilteredTextBoxExtender ID="PhoneNumber1_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="PhoneNumber1">
                    </asp:FilteredTextBoxExtender>
                    <asp:RegularExpressionValidator ID="PhoneNumber1_Format" runat="server" ControlToValidate="PhoneNumber1"
                        ErrorMessage="Phone Number must be in 10-digit US Phone format." ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$" ValidationGroup="CreateUser">*</asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="PhoneNumber2Label" runat="server" AssociatedControlID="PhoneNumber2" SkinID="frmLabel">Phone Number 2</asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="PhoneNumber2" runat="server" class="form-control"></asp:TextBox>
                    <asp:FilteredTextBoxExtender ID="PhoneNumber2_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="PhoneNumber2">
                    </asp:FilteredTextBoxExtender>
                    <asp:RegularExpressionValidator ID="PhoneNumber2_Format" runat="server" ControlToValidate="PhoneNumber2"
                        ErrorMessage="Phone Number must be in 10-digit US Phone format." ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$" ValidationGroup="CreateUser">*</asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" SkinID="frmLabel">Password</asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="Password" runat="server" TextMode="Password" class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword" SkinID="frmLabel">Confirm Password</asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="CreateUser"></asp:CompareValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" SkinID="frmLabel">E-mail</asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="Email" runat="server" class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUser">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="EmailFormat" runat="server" ControlToValidate="Email" ErrorMessage="Email must be in example@example.com format." ToolTip="Email is Required" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="CreateUser">*</asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="ChooseUserRoleLabel" runat="server" AssociatedControlID="rblRoleList" SkinID="frmLabel">Choose User Role</asp:Label>
                <div class="col-lg-9">
                    <asp:RadioButtonList ID="rblRoleList" runat="server" DataTextField="RoleName" DataValueField="RoleName" DataSourceID="RolesSource"></asp:RadioButtonList>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-3">
                    <asp:Button ID="BtnCreateUser" runat="server" Text="Create User" CausesValidation="true" CssClass="btn btn-primary" />
                    <asp:Button ID="BtnCancel" runat="server" Text="Cancel" CausesValidation="false" CssClass="btn btn-default" />
                </div>
            </div>
        </div>
    </asp:Panel>

    <div class="form-horizontal">
    </div>
    <asp:SqlDataSource ID="RolesSource" runat="server" ConnectionString="<%$ ConnectionStrings:DMAConnectionString %>" SelectCommand="GetRoles" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="RoleName" SessionField="UserRole" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%--<uc1:createUser runat="server" ID="createUser" />--%>
</asp:Content>

