<%@ Page Title="Check Deposit Management" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="checkDepositManagement.aspx.cs" Inherits="manage_CheckDepositManagement" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel runat="server" CssClass="panel panel-default" ID="pnlCheckMgmt">
        <div class="panel-heading">Check Management</div>
        <div class="panel-body">
            <div class="form-horizontal">
                <asp:UpdatePanel runat="server" ID="updtCheckMgmt">
                    <ContentTemplate>
                        <div class="form-group">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Bold="True" ForeColor="Red" />
                        </div>
                        <div class="form-group">
                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="sds_CheckOrderManagement">
                                <Columns>
                                    <asp:CommandField ShowEditButton="True" />
                                    <asp:BoundField DataField="orderDate" DataFormatString="{0:d}" HeaderText="Order Date" SortExpression="orderDate" />
                                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" InsertVisible="False" ReadOnly="True" />
                                    <asp:BoundField DataField="DevoteeFullName" HeaderText="Devotee Name" SortExpression="DevoteeFullName" ReadOnly="True" />
                                    <asp:BoundField DataField="checkNumber" HeaderText="Check Number" SortExpression="checkNumber" />
                                    <asp:BoundField DataField="checkDate" HeaderText="Check Date" SortExpression="checkDate" DataFormatString="{0:d}" />
                                    <asp:BoundField DataField="orderTotal" HeaderText="Order Total" SortExpression="orderTotal" DataFormatString="{0:c}" />
                                    <asp:BoundField DataField="checkDepositDate" DataFormatString="{0:d}" HeaderText="Check Deposit Date" SortExpression="checkDepositDate" />
                                    <asp:BoundField DataField="checkDepositregisteredBy" HeaderText="Deposit Registered By" SortExpression="checkDepositregisteredBy" />
                                </Columns>
                            </asp:GridView>
                            <asp:GridView ID="gvCheckManagement" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="Service_Request_ID" DataSourceID="sds_CheckManagement" OnRowUpdating="gvCheckManagement_RowUpdating"
                                AllowSorting="True" AllowPaging="True">
                                <Columns>
                                    <asp:CommandField ShowEditButton="True">
                                        <ControlStyle Width="50px" />
                                    </asp:CommandField>
                                    <asp:BoundField DataField="Service_Date" HeaderText="Service Date" ReadOnly="True" SortExpression="Service_Date" DataFormatString="{0: MM/dd/yyyy}" />
                                    <asp:BoundField DataField="Service_Request_ID" HeaderText="Request ID" InsertVisible="False" ReadOnly="True" SortExpression="Service_Request_ID" />
                                    <asp:BoundField DataField="Name" HeaderText="Devotee Name" ReadOnly="True" SortExpression="Name">
                                        <ControlStyle Width="120px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Check_Number" HeaderText="Check Number" ReadOnly="True" SortExpression="Check_Number" />
                                    <asp:BoundField DataField="Check_Date" HeaderText="Check Date" ReadOnly="True" SortExpression="Check_Date" DataFormatString="{0: MM/dd/yyyy}" />
                                    <asp:BoundField DataField="Service_Fee_Paid" HeaderText="Fee" ReadOnly="True" SortExpression="Service_Fee_Paid" />
                                    <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status" />
                                    <asp:TemplateField HeaderText="Check Deposit Date" SortExpression="Check_Deposit_Date">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblcheckDepositDate" Text='<%# Bind("Check_Deposit_Date", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" ID="checkDepositDate" Text='<%# Bind("Check_Deposit_Date", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="checkDepositDate_CalendarExtender" runat="server" Enabled="True" TargetControlID="checkDepositDate">
                                            </ajaxToolkit:CalendarExtender>
                                            <asp:RequiredFieldValidator ID="rfvCheckDepositDate" runat="server" ControlToValidate="checkDepositDate" ErrorMessage="Please select a date to Update or select Cancel" Font-Bold="True" ForeColor="Red" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ControlStyle Width="70px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Check_Deposit_Registered_By" HeaderText="Deposit Registered By" ReadOnly="true" SortExpression="Check_Deposit_Registered_By" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="gvCheckManagement" EventName="RowCommand" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </asp:Panel>
    <asp:SqlDataSource ID="sds_CheckManagement" runat="server"
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="CheckServices_Select" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE Service_Requests SET Check_Deposit_Date = @chkDepositDt, Check_Deposit_Registered_By = @chkDepositRegby WHERE (Service_Request_ID = @ServiceRequestId)">
        <UpdateParameters>
            <asp:Parameter Name="chkDepositDt" />
            <asp:Parameter Name="chkDepositRegby" />
            <asp:Parameter Name="ServiceRequestId" />
        </UpdateParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="sds_CheckOrderManagement" runat="server"
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="CheckOrders_SelectAll" SelectCommandType="StoredProcedure"
        UpdateCommand="CheckOrders_Update" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="checkDepositDate" Type="String" />
            <asp:Parameter Name="checkDepositedBy" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

