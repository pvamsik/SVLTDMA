<%@ Page Title="Sales" Language="C#" MasterPageFile="~/admin.master" Theme="Admin" AutoEventWireup="true" CodeFile="sales.aspx.cs" Inherits="manage_sales" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(function () {
            var currentDate = new Date();
            $("#ctl00_ContentPlaceHolder1_txtServiceDate").datepicker({
                showOtherMonths: true,
                selectOtherMonths: true
            });
            $("#ctl00_ContentPlaceHolder1_txtServiceDate").datepicker("setDate", currentDate);
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset class="form-horizontal">
        <legend>Sales</legend>
        <div class="form-group">
            <asp:Label ID="Label2" runat="server" SkinID="frmLabel" AssociatedControlID="txtServiceDate" Text="Sales Date"></asp:Label>
            <div class="col-lg-9">
                <asp:TextBox ID="txtServiceDate" runat="server" CssClass="form-control date" AutoPostBack="true"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <asp:UpdatePanel runat="server" ID="sales">
                <ContentTemplate>
                    <div class="col-lg-8">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True"
                            DataKeyNames="Order_Number" DataSourceID="sdsSalesbyDay">
                            <Columns>
                                <asp:BoundField DataField="Service_Date" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Service Date" SortExpression="Service_Date" />
                                <asp:BoundField DataField="Created_Date" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Transaction Date" SortExpression="Created_Date" />
                                <asp:BoundField DataField="Order_Number" HeaderText="Order Number" InsertVisible="False" ReadOnly="True" SortExpression="Order_Number" />
                                <asp:TemplateField SortExpression="Devotee_Last_Name" HeaderText="Devotee Name">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Devotee_Last_Name" Text='<%# Eval("Devotee_Last_Name") %>' />&nbsp;
                                <asp:Label runat="server" ID="Devotee_First_Name" Text='<%# Eval("Devotee_First_Name") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Service_Name" HeaderText="Service Name" SortExpression="Service_Name" />
                                <asp:TemplateField SortExpression="Service_Name" HeaderText="Service Info">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Payment_type_description" Text='<%# Eval("Payment_type_description") %>' />
                                        <asp:Label runat="server" ID="Check_Number" Text='<%# Eval("Check_Number") %>' /><br />
                                        <asp:Label runat="server" ID="TransactionID" Text='<%# Eval("TransactionID") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="150px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Check_Date" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Check Date" SortExpression="Check_Date" />
                                <asp:BoundField DataField="Fee_Paid" HeaderText="Fee" SortExpression="Fee_Paid" DataFormatString="{0:c}" />
                                <asp:BoundField DataField="CreatedBy" HeaderText="Sale By" SortExpression="CreatedBy" />
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="col-lg-4">
                        <asp:GridView ID="SalesByServiceType" runat="server" AutoGenerateColumns="False" DataSourceID="sdsSalesByType">
                            <Columns>
                                <asp:BoundField DataField="Service Type" HeaderText="Service Type" SortExpression="Service Type" />
                                <asp:BoundField DataField="Sales" HeaderText="Sales" SortExpression="Sales" />
                            </Columns>
                        </asp:GridView>
                        <asp:GridView ID="SalesByServiceTypePaymentType" runat="server" AutoGenerateColumns="False" DataSourceID="sdsSalesByServiceTypeAndPaymentType">
                            <Columns>
                                <asp:BoundField DataField="Service Type" HeaderText="Service Type" SortExpression="Service Type" />
                                <asp:BoundField DataField="Payment Type" HeaderText="Payment Type" SortExpression="Payment Type" />
                                <asp:BoundField DataField="Sales" HeaderText="Sales" SortExpression="Sales" />
                            </Columns>
                        </asp:GridView>
                        <asp:GridView ID="SalesByCardType" runat="server" AutoGenerateColumns="False" DataSourceID="sds_SalesbyCardType">
                            <Columns>
                                <asp:BoundField DataField="Card Type" HeaderText="Card Type" SortExpression="Card Type" />
                                <asp:BoundField DataField="SALES" HeaderText="SALES" SortExpression="SALES" />
                            </Columns>
                        </asp:GridView>
                        <br />
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="txtServiceDate" EventName="TextChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </fieldset>
    <asp:SqlDataSource ID="sdsSalesbyDay" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="GetServiceHistorybyDay" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtServiceDate" Name="serviceDate" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <%--<asp:SqlDataSource ID="sdsSalesByDay1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        SelectCommand="SELECT Devotee_Last_Name, Devotee_First_Name, Service_Request_ID, Service_Date, Service_Fee_Paid, Service_Name, Service_type, Payment_type_code, Check_Number, Created_Date, CreatedBy FROM DevoteeRequests WHERE (Service_Date = @serviceDate) ORDER BY Service_Date DESC, Service_Request_ID DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtServiceDate" Name="serviceDate" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="sds_SalesbyCardType" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT * FROM [SalesByCardType] WHERE ([Service Date] = @Service_Date)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtServiceDate" Name="Service_Date" PropertyName="Text" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSalesByType" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT * FROM [SalesByServiceType] WHERE ([Service_Date] = @Service_Date)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtServiceDate" Name="Service_Date" PropertyName="Text" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSalesByServiceTypeAndPaymentType" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT * FROM [SalesByServiceTypeAndPaymentType] WHERE ([Service Date] = @Service_Date)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtServiceDate" Name="Service_Date" PropertyName="Text" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%--<asp:GridView ID="SalesByDay1" runat="server" AutoGenerateColumns="False" DataKeyNames="Service_Request_ID" DataSourceID="sdsSalesByDay" Width="100%" AllowPaging="True" AllowSorting="True">
                    <Columns>
                        <asp:BoundField DataField="Service_Date" HeaderText="Service Date" SortExpression="Service_Date" DataFormatString="{0:MM/dd/yyyy}" />
                        <asp:BoundField DataField="Created_Date" HeaderText="Transaction Date" SortExpression="Created_Date" DataFormatString="{0:MM/dd/yyyy hh:mm tt}" />
                        <asp:BoundField DataField="Service_Request_ID" HeaderText="Request ID" ReadOnly="True" SortExpression="Service_Request_ID" />
                        <asp:TemplateField SortExpression="Devotee_Last_Name" HeaderText="Devotee Name">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="Devotee_Last_Name" Text='<%# Eval("Devotee_Last_Name") %>' />&nbsp;
                                <asp:Label runat="server" ID="Devotee_First_Name" Text='<%# Eval("Devotee_First_Name") %>' /> 
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="Service_Name" HeaderText="Service Info">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="Service_Name" Text='<%# Eval("Service_Name") %>' /><br />
                                <asp:Label runat="server" ID="Service_Type" Text='<%# Eval("Service_type") %>' /><br />
                                <asp:Label runat="server" ID="Payment_type_code" Text='<%# Eval("Payment_type_code") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Service_Fee_Paid" HeaderText="Fee Paid" SortExpression="Service_Fee_Paid" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="CreatedBy" HeaderText="Sale By" SortExpression="CreatedBy" />
                    </Columns>
                </asp:GridView>--%>
</asp:Content>

