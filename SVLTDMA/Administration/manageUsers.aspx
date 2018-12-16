<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="manageUsers.aspx.cs" Inherits="Administration_userSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel runat="server" ID="pnlManageUsers" CssClass="panel panel-default">
        <div class="panel-heading">Manage Users</div>
        <div class="panel-body">
            <div class="col-lg-8">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    AllowSorting="True" AllowPaging="True" PageSize="15"
                    DataSourceID="SqlDataSource1"
                    OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                    OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:CommandField SelectText="Edit" ShowSelectButton="True" HeaderText="Edit" />
                        <asp:ButtonField CommandName="Unlock" HeaderText="Unlock" ShowHeader="True" Text="Unlock" />
                        <asp:ButtonField CommandName="Reset" HeaderText="Reset" ShowHeader="True" Text="Reset" />
                        <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
                        <asp:BoundField DataField="RoleName" HeaderText="RoleName" SortExpression="RoleName" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ItemStyle-Width="100">
                            <ItemStyle Width="100px"></ItemStyle>
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="IsApproved" HeaderText="IsApproved" SortExpression="IsApproved" />
                        <asp:CheckBoxField DataField="IsLockedOut" HeaderText="IsLockedOut" SortExpression="IsLockedOut" />
                    </Columns>
                </asp:GridView>
            </div>
            <div class="col-lg-4">
                <div id="messageDiv" runat="server">
                </div>
                <div id="messageDiv2" runat="server" class="alert alert-dismissible alert-success hidden">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <asp:Label runat="server" ID="lblPwdReset" Text="" />
                </div>
                <p>
                    <asp:Label runat="server" ID="lblMessage" Text="" SkinID="frmErrorLabel" />
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="ModifyUserGroup" />
                    <p>
                        <asp:Label runat="server" ID="lblError" Text="" SkinID="frmErrorLabel" />
                    </p>
                <div id="manageUser" runat="server" visible="false">
                    <div class="form-horizontal">
                        <fieldset>
                            <legend>Modify User Details</legend>
                            <div class="form-group">
                                <asp:Label runat="server" ID="Label1" Text="You are managing:" CssClass="col-lg-4 control-label" />
                                <label>
                                    <asp:Label runat="server" ID="lblUserName" CssClass="col-lg-8 control-label text-left" Text="User Name" />
                                </label>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" ID="dspName" Text="User Full Name:" CssClass="col-lg-4 control-label" />
                                <div class="col-lg-8">
                                    <asp:TextBox runat="server" ID="txtFullName" CssClass="form-control" Text="" />
                                    <asp:RequiredFieldValidator ID="txtFullNameRequired" runat="server" Text="*" ControlToValidate="txtFullName"
                                        Display="Dynamic" ValidationGroup="ModifyUserGroup" ErrorMessage="User Name is Required."></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" ID="dspEmail" Text="Email:" CssClass="col-lg-4 control-label" />
                                <div class="col-lg-8">
                                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" Text="" />
                                    <asp:RegularExpressionValidator ID="txtEmailFormatValidator" runat="server" Text="*" ControlToValidate="txtEmail"
                                        Display="Dynamic" ValidationGroup="ModifyUserGroup" ErrorMessage="Email must be in example@server.com format." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="txtEmailRequired" runat="server" Text="*" ControlToValidate="txtEmail"
                                        Display="Dynamic" ValidationGroup="ModifyUserGroup" ErrorMessage="Email is Required.">*</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" ID="dspPhone1" Text="Phone Number 1:" CssClass="col-lg-4 control-label" />
                                <div class="col-lg-8">
                                    <asp:TextBox runat="server" ID="txtPhone1" CssClass="form-control" Text="" />
                                    <asp:RequiredFieldValidator ID="txtPhone1Required" runat="server" ControlToValidate="txtPhone1" Text="*" Display="Dynamic" ErrorMessage="Phone 1 is required." ValidationGroup="ModifyUserGroup"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtPhone1Validator" runat="server" ControlToValidate="txtPhone1" Text="*" Display="Dynamic" ErrorMessage="Phone Number 1 must be in US Phone Format." ValidationGroup="ModifyUserGroup" ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$">*</asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" ID="dspPhone2" Text="Phone Number 2:" CssClass="col-lg-4 control-label" />
                                <div class="col-lg-8">
                                    <asp:TextBox runat="server" ID="txtPhone2" CssClass="form-control" Text="" />
                                    <asp:RegularExpressionValidator ID="txtPhone2Validator" runat="server" ControlToValidate="txtPhone2" Text="*" Display="Dynamic" ErrorMessage="Phone Number 2 must be in US Phone Format." ValidationGroup="ModifyUserGroup" ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$">*</asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" ID="dspApproved" Text="Approved:" CssClass="col-lg-4 control-label" />
                                <div class="col-lg-8">
                                    <div class="checkbox">
                                        <label>
                                            <asp:CheckBox runat="server" ID="chkApproved" />
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" ID="dspRole" Text="User Role:" CssClass="col-lg-4 control-label" />
                                <div class="col-lg-8">
                                    <div class="radio">
                                        <label>
                                            <asp:RadioButtonList runat="server" ID="rblRoleList" DataTextField="RoleName" DataValueField="RoleName" RepeatDirection="Vertical" RepeatLayout="Flow"></asp:RadioButtonList>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group text-center">
                                <asp:Button runat="server" ID="cmdSubmit" Text="Update" CssClass="btn btn-primary" CausesValidation="true" ValidationGroup="ModifyUserGroup" OnClick="cmdSubmit_Click" />
                                <asp:Button runat="server" ID="cmdCancel" Text="Cancel" CssClass="btn btn-default" CausesValidation="false" OnClick="cmdCancel_Click" />
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div class="row">
    </div>
    <%--    <uc1:ManageUsers runat="server" ID="ManageUsers" />--%>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="GetManageableUsers" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="RoleName" SessionField="UserRole" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

