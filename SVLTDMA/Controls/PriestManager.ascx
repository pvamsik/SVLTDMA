<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PriestManager.ascx.cs" Inherits="Controls_PriestManager" %>
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" 
    AutoGenerateColumns="False" DataKeyNames="Priest_ID" DataSourceID="SqlDataSource1" 
    OnRowDeleted="GridView1_RowDeleted" OnRowUpdated="GridView1_RowUpdated">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:BoundField DataField="Priest_ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Priest_ID" />
        <asp:BoundField DataField="Priest_First_Name" HeaderText="First Name" SortExpression="First Name" />
        <asp:BoundField DataField="Priest_Last_Name" HeaderText="Last Name" SortExpression="Priest_Last_Name" />
        <asp:CheckBoxField DataField="Priest_Active" HeaderText="Active" SortExpression="Priest_Active" />
    </Columns>
</asp:GridView>

<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
    SelectCommand="SELECT Priest_ID, Priest_First_Name, Priest_Last_Name, Priest_Active, Priest_Create_Date, Priest_CreatedBy, Priest_Last_Modified_Date, Priest_ModifiedBy FROM Priest" 
    InsertCommand="INSERT INTO Priest(Priest_First_Name, Priest_Last_Name, Priest_Active, Priest_Create_Date, Priest_CreatedBy) VALUES (@priestFName, @priestLName, @priestActive, @priestCreatedDt, @priestCreatedBy)" 
    UpdateCommand="UPDATE Priest SET Priest_First_Name = @priestFName, Priest_Last_Name = @priestLName, Priest_Last_Modified_Date = @priestLastModifiedDt, Priest_ModifiedBy = @priestLastModifiedBy WHERE (Priest_ID = @priestID)"
    DeleteCommand="DELETE FROM Priest WHERE (Priest_ID = @priestID)" >
    <DeleteParameters>
        <asp:Parameter Name="priestID" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="priestFName" />
        <asp:Parameter Name="priestLName" />
        <asp:Parameter Name="priestActive" />
        <asp:Parameter Name="priestCreatedDt" />
        <asp:Parameter Name="priestCreatedBy" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="priestFName" />
        <asp:Parameter Name="priestLName" />
        <asp:Parameter Name="priestLastModifiedDt" />
        <asp:Parameter Name="priestLastModifiedBy" />
        <asp:Parameter Name="priestID" />
    </UpdateParameters>
</asp:SqlDataSource>

