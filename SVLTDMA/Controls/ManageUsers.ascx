<%@ Control Language="C#" AutoEventWireup="true" EnableTheming="true" CodeFile="manageUsers.ascx.cs" Inherits="Controls_manageUsers" %>
<asp:Panel runat="server" ID="pnlManageServices" CssClass="panel panel-default">
    <div class="panel-heading">Manage Users</div>
    <div class="panel-body">
        <div class="form-horizontal">
            <div class="form-group">
                <asp:Label runat="server" ID="lblMessage" Text="" SkinID="frmErrorLabel" />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="ModifyUserGroup" />
                <asp:Label runat="server" ID="lblError" Text="" SkinID="frmErrorLabel" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-8">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowSorting="True" DataKeyNames="UserName"
                    OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                    OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:ButtonField CommandName="Reset" Text="Reset Pwd" />
                        <asp:ButtonField CommandName="Unlock" Text="Unlock" />
                        <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName" />
                        <asp:BoundField DataField="RoleName" HeaderText="Role Name" SortExpression="RoleName" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ItemStyle-Width="100">
                            <ItemStyle Width="100px"></ItemStyle>
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="IsApproved" HeaderText="Active" SortExpression="IsApproved" />
                        <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Locked Out?" SortExpression="IsLockedOut" />
                    </Columns>
                </asp:GridView>
            </div>
            <div class="col-lg-4">
                <fieldset class="form-horizontal" id="manageUser" runat="server" visible="false">
                    <legend>Edit User Details</legend>
                    <div class="form-group">
                        <asp:Label runat="server" ID="dspUserName" Text="User Name" AssociatedControlID="lblUserName" SkinID="frmLabel" />
                        <asp:Label runat="server" ID="lblUserName" Text="" CssClass="text-left" SkinID="frmLabel" />
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="dspName" Text="User Full Name" AssociatedControlID="txtFullName" SkinID="frmLabel" />
                        <asp:TextBox runat="server" ID="txtFullName" Text="" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="txtFullNameRequired" runat="server" ControlToValidate="txtFullName" ValidationGroup="ModifyUserGroup" ErrorMessage="User Name is Required."></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="dspEmail" Text="Email" AssociatedControlID="txtEmail" SkinID="frmLabel" />
                        <asp:TextBox runat="server" ID="txtEmail" Text="" CssClass="form-control" />
                        <asp:RegularExpressionValidator ID="txtEmailFormatValidator" runat="server" Text="*" ControlToValidate="txtEmail" Display="Dynamic" ValidationGroup="ModifyUserGroup" ErrorMessage="Email must be in example@server.com format." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="txtEmailRequired" runat="server" Text="*" ControlToValidate="txtEmail" Display="Dynamic" ValidationGroup="ModifyUserGroup" ErrorMessage="Email is Required.">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="dspPhone1" Text="Phone Number 1" AssociatedControlID="txtPhone1" SkinID="frmLabel" />
                        <asp:TextBox runat="server" ID="txtPhone1" Text="" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="txtPhone1Required" runat="server" ControlToValidate="txtPhone1" Text="*" Display="Dynamic" ErrorMessage="Phone 1 is required." ValidationGroup="ModifyUserGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="txtPhone1Validator" runat="server" ControlToValidate="txtPhone1" Text="*" Display="Dynamic" ErrorMessage="Phone Number 1 must be in US Phone Format." ValidationGroup="ModifyUserGroup" ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$">*</asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="dspPhone2" Text="Phone Number 2" AssociatedControlID="txtPhone2" SkinID="frmLabel" />
                        <asp:TextBox runat="server" ID="txtPhone2" Text="" CssClass="form-control" />
                        <asp:RegularExpressionValidator ID="txtPhone2Validator" runat="server" ControlToValidate="txtPhone2" Text="*" Display="Dynamic" ErrorMessage="Phone Number 2 must be in US Phone Format." ValidationGroup="ModifyUserGroup" ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$">*</asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="dspApproved" Text="Approved" AssociatedControlID="chkApproved" SkinID="frmLabel" />
                        <asp:CheckBox runat="server" ID="chkApproved" />
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="dspRole" Text="User Role" AssociatedControlID="rblRoleList" SkinID="frmLabel" />
                        <asp:RadioButtonList runat="server" ID="rblRoleList" DataTextField="RoleName" DataValueField="RoleName"></asp:RadioButtonList>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-2"></div>
                        <asp:Button runat="server" ID="cmdSubmit" Text="Update" CausesValidation="true" ValidationGroup="ModifyUserGroup" OnClick="cmdSubmit_Click" CssClass="btn btn-lg btn-primary" />
                        <asp:Button runat="server" ID="cmdCancel" Text="Cancel" CausesValidation="false" OnClick="cmdCancel_Click" CssClass="btn btn-lg btn-info" />
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10"></div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</asp:Panel>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="SELECT Users.UserName, Roles.RoleName, Memberships.Email, Memberships.IsApproved, Memberships.IsLockedOut FROM Roles INNER JOIN UsersInRoles ON Roles.RoleId = UsersInRoles.RoleId INNER JOIN Users ON UsersInRoles.UserId = Users.UserId INNER JOIN Memberships ON Users.UserId = Memberships.UserId ORDER BY Roles.RoleName, Users.UserName"></asp:SqlDataSource>
