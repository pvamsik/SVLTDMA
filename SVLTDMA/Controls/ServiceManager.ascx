﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ServiceManager.ascx.cs" Inherits="Controls_ServiceManager" %>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:GridView ID="GridView1" runat="server"
            AutoGenerateColumns="False" AutoGenerateDeleteButton="True" AutoGenerateEditButton="True"
            DataKeyNames="Service_ID" DataSourceID="SqlDataSource1"
            AllowPaging="True" AllowSorting="True"
            OnRowDeleted="GridView1_RowDeleted" OnRowUpdated="GridView1_RowUpdated">
            <Columns>
                <asp:BoundField DataField="Service_type_description" HeaderText="Service Location" SortExpression="Service_type_description" ReadOnly="True">
                    <ControlStyle Width="200px" />
                <ItemStyle Width="250px" />
                </asp:BoundField>
                <asp:BoundField DataField="Service_Name" HeaderText="Service Name" SortExpression="Service_Name">
                    <ControlStyle Width="150px" />
                <ItemStyle Width="225px" />
                </asp:BoundField>
                <asp:BoundField DataField="Service_Description" HeaderText="Service Description" SortExpression="Service_Description">
                    <ControlStyle Width="250px" />
                <ItemStyle Width="225px" />
                </asp:BoundField>
                <asp:BoundField DataField="Service_Fee" HeaderText="Service Fee" SortExpression="Service_Fee" DataFormatString="{0:c}" ApplyFormatInEditMode="True">
                    <ControlStyle Width="75px" />
                    <ItemStyle Width="100px" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="PageIndexChanged" />
    </Triggers>
</asp:UpdatePanel>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    DeleteCommand="UPDATE Service SET IsActive = 0 WHERE (Service_ID = @serviceId)"
    SelectCommand="SELECT Service.Service_Type_ID, Service_Type.Service_type, Service_Type.Service_type_description, Service.Service_ID, Service.Service_Name, Service.Service_Description, Service.Service_Fee FROM Service INNER JOIN Service_Type ON Service.Service_Type_ID = Service_Type.Service_Type_ID WHERE Service.IsActive = 1 ORDER BY Service.Service_Type_ID"
    UpdateCommand="UPDATE Service SET Service_Name = @serviceName, Service_Description = @serviceDescription, Service_Fee = @serviceFee FROM Service INNER JOIN Service_Type ON Service.Service_Type_ID = Service_Type.Service_Type_ID WHERE Service.Service_ID = @serviceId">
    <DeleteParameters>
        <asp:Parameter Name="serviceId" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="serviceId" />
        <asp:Parameter Name="serviceName" />
        <asp:Parameter Name="serviceDescription" />
        <asp:Parameter Name="serviceFee" DbType="Currency" />
    </UpdateParameters>
</asp:SqlDataSource>
