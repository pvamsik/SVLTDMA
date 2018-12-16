<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DeleteUser.ascx.cs" Inherits="Controls_DeleteUser" %>
<asp:GridView ID="gvUserList" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="UserName" DataSourceID="sqlgvUserList" ForeColor="#333333" GridLines="None" OnRowCommand="gvUserList_RowCommand">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:BoundField DataField="UserId" HeaderText="UserId" ReadOnly="True" SortExpression="UserId" />
        <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
        <asp:BoundField DataField="RoleName" HeaderText="RoleName" SortExpression="RoleName" />
        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
        <asp:CommandField ShowDeleteButton="True" />
    </Columns>
    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <SortedAscendingCellStyle BackColor="#FDF5AC" />
    <SortedAscendingHeaderStyle BackColor="#4D0000" />
    <SortedDescendingCellStyle BackColor="#FCF6C0" />
    <SortedDescendingHeaderStyle BackColor="#820000" />
</asp:GridView>
<asp:SqlDataSource ID="sqlgvUserList" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="SELECT Users.UserId, Users.UserName, Roles.RoleName, Memberships.Email FROM Users INNER JOIN UsersInRoles ON Users.UserId = UsersInRoles.UserId INNER JOIN Roles ON UsersInRoles.RoleId = Roles.RoleId INNER JOIN Memberships ON Users.UserId = Memberships.UserId ORDER BY Roles.RoleName"></asp:SqlDataSource>

