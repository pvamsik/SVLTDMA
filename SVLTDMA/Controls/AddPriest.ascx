<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddPriest.ascx.cs" Inherits="Controls_AddPriest" %>

<style>
    #addPriestPanel
    {
        width: 200px;
        height: 200px;
        text-align: left;
    }

    .header
    {
        text-align: center;
    }
</style>
<asp:Panel ID="addPriestPanel" runat="server">
    <div id="header">
        <h2>Add Priest</h2>
    </div>
    <p>
        <asp:Label ID="Label1" runat="server" Text="First Name" SkinID="frmLabel"></asp:Label>
        <asp:TextBox ID="txtPriestFirstName" runat="server"></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="Label2" runat="server" SkinID="frmLabel" Text="Last Name:"></asp:Label>
        <asp:TextBox ID="txtPriestLastName" runat="server"></asp:TextBox>
    </p>
    <asp:Button ID="cmdAddPriest" runat="server" Text="Add Priest" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" OnClick="cmdAddPriest_Click"></asp:Button>
    <p>
        <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
    </p>
    <asp:SqlDataSource ID="sqlDSPriestsData" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" InsertCommand="INSERT INTO Priest(Priest_First_Name, Priest_Last_Name, Priest_Active, Priest_Create_Date, Priest_CreatedBy, Priest_Last_Modified_Date, Priest_ModifiedBy) VALUES (@firstName, @lastName, @active, @createDate, @createdBy, @modifyDate, @modifiedBy)" SelectCommand="SELECT Priest_First_Name AS PriestFirstName, Priest_Last_Name AS PriestLastName, Priest_Active, Priest_Create_Date, Priest_CreatedBy, Priest_Last_Modified_Date, Priest_ModifiedBy FROM Priest">
        <InsertParameters>
            <asp:Parameter Name="firstName" />
            <asp:Parameter Name="lastName" />
            <asp:Parameter Name="active" DbType="Boolean" DefaultValue="true" />
            <asp:Parameter Name="createDate" DbType="DateTime" />
            <asp:Parameter Name="createdBy" />
            <asp:Parameter Name="modifyDate" DbType="DateTime" />
            <asp:Parameter Name="modifiedBy" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Panel>

