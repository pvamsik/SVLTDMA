<%@ Page Title="Today's Sales" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="sales.aspx.cs" Inherits="manage_Sales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(function () {
            var currentDate = new Date();
            $("#ctl00_ContentPlaceHolder1_txtServiceDate").datepicker({
                minDate: "-7D",
                maxDate: 0
            });
            $("#ctl00_ContentPlaceHolder1_txtServiceDate").datepicker("setDate", currentDate);
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset class="form-horizontal">
        <legend>Daily Sales</legend>
        <div class="form-group">
            <asp:Label ID="Label2" runat="server" SkinID="frmLabel" AssociatedControlID="txtServicedate" Text="Date"></asp:Label>
            <div class="col-lg-9">
                <asp:TextBox ID="txtServiceDate" runat="server" CssClass="date form-control" AutoPostBack="true"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <asp:UpdatePanel runat="server" ID="sales">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True"
                        DataKeyNames="Order_Number" DataSourceID="sdsSalesbyDay">
                        <Columns>
                            <asp:BoundField DataField="Service_Date" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Service Date" SortExpression="Service_Date" />
                            <asp:BoundField DataField="Created_Date" DataFormatString="{0:MM/dd/yyyy hh:mm tt}" HeaderText="Transaction Date" SortExpression="Created_Date" />
                            <asp:BoundField DataField="Order_Number" HeaderText="Order Number" InsertVisible="False" ReadOnly="True" SortExpression="Order_Number" />
                            <asp:TemplateField SortExpression="Devotee_Last_Name" HeaderText="Devotee Name">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="Devotee_Last_Name" Text='<%# Eval("Devotee_Last_Name") %>' />&nbsp;
                                <asp:Label runat="server" ID="Devotee_First_Name" Text='<%# Eval("Devotee_First_Name") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField SortExpression="Service_Name" HeaderText="Service Info">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="Service_Name" Text='<%# Eval("Service_Name") %>' /><br />
                                    <asp:Label runat="server" ID="Service_Type" Text='<%# Eval("Service_type_description") %>' /><br />
                                    <asp:Label runat="server" ID="Payment_type_description" Text='<%# Eval("Payment_type_description") %>' />
                                    <asp:Label runat="server" ID="Check_Number" Text='<%# Eval("Check_Number") %>' /><br />
                                    <asp:Label runat="server" ID="Check_Date" Text='<%# Eval("Check_Date", "{0:MM/dd/yyyy}") %>' />
                                    <asp:Label runat="server" ID="TransactionID" Text='<%# Eval("TransactionID") %>' />
                                </ItemTemplate>
                                <ItemStyle Width="150px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Fee_Paid" HeaderText="Fee" SortExpression="Fee_Paid" DataFormatString="{0:c}" />
                            <asp:BoundField DataField="CreatedBy" HeaderText="Sale By" SortExpression="CreatedBy" />
                        </Columns>
                    </asp:GridView>
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
</asp:Content>

