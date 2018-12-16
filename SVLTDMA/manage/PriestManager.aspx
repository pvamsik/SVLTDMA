<%@ Page Title="Priest Manager" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="PriestManager.aspx.cs" Inherits="manage_PriestManager" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        #addPriestPanel {
            width: 200px;
            height: 200px;
            text-align: left;
        }

        .header {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="form-group">
        <div class="col-lg-6">
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
        </div>
        <div class="col-lg-6">
            <asp:Panel ID="addPriestPanel" runat="server">
                <div>
                    <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
                </div>
                <fieldset class="form-horizontal">
                    <legend>Add Priest</legend>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" SkinID="frmLabel" AssociatedControlID="txtPriestFirstName" Text="First Name"></asp:Label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtPriestFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" SkinID="frmLabel" AssociatedControlID="txtPriestLastName" Text="Last Name"></asp:Label>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtPriestLastName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-2"></div>
                        <asp:Button ID="cmdAddPriest" runat="server" Text="Add Priest" CssClass="btn btn-lg btn-primary" OnClick="cmdAddPriest_Click"></asp:Button>
                    </div>
                </fieldset>
            </asp:Panel>
        </div>
    </div>
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
</asp:Content>

