<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Relations.aspx.cs" Inherits="manage_Relations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
<asp:GridView ID="gvRelations" runat="server" AllowPaging="True" AllowSorting="True"
    AutoGenerateColumns="False" DataKeyNames="Relation_ID" DataSourceID="SDS_Relations">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:BoundField DataField="Relation_ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Relation_ID" />
        <asp:BoundField DataField="Relation_Name" HeaderText="Relationship" SortExpression="Relation_Name" />
        <asp:BoundField DataField="Relation_Description" HeaderText="Description" SortExpression="Relation_Description" />
        <asp:BoundField DataField="Relation_Order" HeaderText="Order" SortExpression="Relation_Order" />
    </Columns>
</asp:GridView>

<asp:SqlDataSource ID="SDS_Relations" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="SELECT * FROM dbo.relations"
    InsertCommand="INSERT INTO dbo.Relations(relation_name, [relation_description], [relation_order] ) VALUES (@priestFName, @priestLName, @priestActive, @priestCreatedDt, @priestCreatedBy)"
    UpdateCommand="UPDATE Priest SET Priest_First_Name = @priestFName, Priest_Last_Name = @priestLName, Priest_Active = @priestActive, Priest_Last_Modified_Date = @priestLastModifiedDt, Priest_ModifiedBy = @priestLastModifiedBy WHERE (Priest_ID = @priestID)"
    DeleteCommand="DELETE FROM dbo.Relations WHERE (Relation_ID = @priestID)">
    <DeleteParameters>
        <asp:Parameter Name="relation_ID" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="relation_name" />
        <asp:Parameter Name="relation_description" />
        <asp:Parameter Name="relation_order" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="priestFName" />
        <asp:Parameter Name="priestLName" />
        <asp:Parameter Name="priestActive" />
        <asp:Parameter Name="priestLastModifiedDt" DbType="DateTime" />
        <asp:Parameter Name="priestLastModifiedBy" />
        <asp:Parameter Name="priestID" />
    </UpdateParameters>
</asp:SqlDataSource>



</asp:Content>

