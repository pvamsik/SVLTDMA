<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ManagePriest.ascx.cs" Inherits="Controls_ManagePriest" %>

<%--<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<ext:ResourceManager ID="resourcemanager1" runat="server"></ext:ResourceManager>

<ext:GridPanel ID="GridPanel1" runat="server" Title="Priest Information" Width="450" Height="200">
    <Store>
        <ext:Store runat="server" ID="Store1"
            DataSourceID="SqlDataSource1" AutoDataBind="true" AutoLoad="true" PageSize="10">
            <Model>
                <ext:Model ID="Model1" runat="server">
                    <Fields>
                        <ext:ModelField Name="Priest_ID" />
                        <ext:ModelField Name="Priest_First_Name" Type="String" />
                        <ext:ModelField Name="Priest_Last_Name" Type="String" />
                        <ext:ModelField Name="Priest_Active" Type="Boolean" />
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>
    </Store>
    <ColumnModel runat="server">
        <Columns>
            <ext:Column runat="server" Text="ID" DataIndex="Priest_ID" />
            <ext:Column runat="server" Text="First Name" DataIndex="Priest_First_Name" Flex="1" />
            <ext:Column runat="server" Text="Last Name" DataIndex="Priest_Last_Name" Flex="1" />
            <ext:CheckColumn runat="server" Text="Active" DataIndex="Priest_Active" />
            <ext:CommandColumn ID="CommandColumn1" runat="server" Width="60">
                <Commands>
                    <ext:GridCommand Icon="Delete" CommandName="Delete">
                        <ToolTip Text="Delete" />
                    </ext:GridCommand>
                    <ext:CommandSeparator />
                    <ext:GridCommand Icon="NoteEdit" CommandName="Edit">
                        <ToolTip Text="Edit" />
                    </ext:GridCommand>
                </Commands>
                <Listeners>
                    <Command Handler="Ext.Msg.alert(command, record.data.company);" />
                </Listeners>
            </ext:CommandColumn>
        </Columns>
    </ColumnModel>
    <SelectionModel>
        <ext:RowSelectionModel runat="server" Mode="Single" />
    </SelectionModel>
    <View>
        <ext:GridView runat="server" StripeRows="true" />
    </View>
    <BottomBar>
        <ext:PagingToolbar ID="PagingToolbar1" runat="server" />
    </BottomBar>
</ext:GridPanel>--%>

<asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
    AutoGenerateColumns="False" DataKeyNames="Priest_ID" DataSourceID="SqlDataSource1"
    OnRowDeleted="GridView1_RowDeleted" OnRowUpdated="GridView1_RowUpdated">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:BoundField DataField="Priest_ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Priest_ID" />
        <asp:BoundField DataField="Priest_First_Name" HeaderText="First Name" SortExpression="Priest_First_Name" />
        <asp:BoundField DataField="Priest_Last_Name" HeaderText="Last Name" SortExpression="Priest_Last_Name" />
        <asp:CheckBoxField DataField="Priest_Active" HeaderText="Active" SortExpression="Priest_Active" />
    </Columns>
</asp:GridView>

<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="SELECT Priest_ID, Priest_First_Name, Priest_Last_Name, Priest_Active, Priest_Create_Date, Priest_CreatedBy, Priest_Last_Modified_Date, Priest_ModifiedBy FROM Priest"
    InsertCommand="INSERT INTO Priest(Priest_First_Name, Priest_Last_Name, Priest_Active, Priest_Create_Date, Priest_CreatedBy) VALUES (@priestFName, @priestLName, @priestActive, @priestCreatedDt, @priestCreatedBy)"
    UpdateCommand="UPDATE Priest SET Priest_First_Name = @priestFName, Priest_Last_Name = @priestLName, Priest_Active = @priestActive, Priest_Last_Modified_Date = @priestLastModifiedDt, Priest_ModifiedBy = @priestLastModifiedBy WHERE (Priest_ID = @priestID)"
    DeleteCommand="DELETE FROM Priest WHERE (Priest_ID = @priestID)">
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
        <asp:Parameter Name="priestActive" />
        <asp:Parameter Name="priestLastModifiedDt" DbType="DateTime" />
        <asp:Parameter Name="priestLastModifiedBy" />
        <asp:Parameter Name="priestID" />
    </UpdateParameters>
</asp:SqlDataSource>

