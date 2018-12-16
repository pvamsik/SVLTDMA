<%@ Page Title="Product Sales" Language="C#" MasterPageFile="~/admin.master" Theme="Admin" AutoEventWireup="true" CodeFile="productSales.aspx.cs" Inherits="Administration_productSales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel runat="server" CssClass="panel panel-default">
        <div class="panel-heading">Product Sales</div>
        <div class="panel-body">
            <div class="form-horizontal">
                <div class="form-group">
                    <asp:Label ID="Label2" runat="server" SkinID="frmLabel" AssociatedControlID="DropDownList1" Text="Service"></asp:Label>
                    <div class="col-lg-9">
                        <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                            CssClass="form-control"
                            DataSourceID="sds_Services" DataTextField="Service_Name" DataValueField="Service_Id">
                            <asp:ListItem Value="">Select</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group">
                    <asp:UpdatePanel runat="server" ID="sales">
                        <ContentTemplate>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sds_ServiceRequests" AllowPaging="True" AllowSorting="True">
                                <Columns>
                                    <asp:BoundField DataField="Service_Date" HeaderText="Service Date" SortExpression="Service_Date" DataFormatString="{0:MM/dd/yyyy}" />
                                    <asp:TemplateField SortExpression="Devotee_Last_Name" HeaderText="Devotee Name">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="Devotee_Last_Name" Text='<%# Eval("Devotee_Last_Name") %>' />&nbsp;
                                            <asp:Label runat="server" ID="Devotee_First_Name" Text='<%# Eval("Devotee_First_Name") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Service_Fee_Paid" HeaderText="Service Fee" SortExpression="Service_Fee_Paid" />
                                    <asp:BoundField DataField="Payment_type_description" HeaderText="Payment Type" SortExpression="Payment_type_description" />
                                    <asp:BoundField DataField="Comment1" HeaderText="Field 1" SortExpression="Comment1" />
                                    <asp:BoundField DataField="Comment2" HeaderText="Field 2" SortExpression="Comment2" />
                                    <asp:BoundField DataField="Comment3" HeaderText="Field 3" SortExpression="Comment3" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="DropDownList1" EventName="TextChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </asp:Panel>
    <asp:SqlDataSource ID="sds_ServiceRequests" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="SELECT Service_Requests.Service_Date, Devotee.Devotee_First_Name, Devotee.Devotee_Last_Name, Service_Requests.Service_Fee_Paid, Payment_Type.Payment_type_description, Service_Requests.Comment1, Service_Requests.Comment2, Service_Requests.Comment3 FROM Service_Requests INNER JOIN Devotee ON Service_Requests.Devotee_ID = Devotee.Devotee_ID AND Service_Requests.Devotee_ID = Devotee.Devotee_ID INNER JOIN Payment_Type ON Service_Requests.Payment_Type_ID = Payment_Type.Payment_type_ID AND Service_Requests.Payment_Type_ID = Payment_Type.Payment_type_ID WHERE (Service_Requests.Service_ID = @serviceID) ORDER BY Service_Requests.Service_Date DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="serviceID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_Services" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="SELECT Service_ID, Service_Name FROM Service ORDER BY Service_Name"></asp:SqlDataSource>
</asp:Content>

