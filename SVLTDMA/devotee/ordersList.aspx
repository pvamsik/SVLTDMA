<%@ Page Title="Order List" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="ordersList.aspx.cs" Inherits="devotee_orderList" %>

<%@ Register Src="~/Controls/DevoteeInformation.ascx" TagPrefix="uc1" TagName="DevoteeInformation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:DevoteeInformation runat="server" ID="DevoteeInformation" />
    <asp:Panel runat="server" ID="pnlErrorMessage" Visible="false" CssClass="panel panel-default">
        <div class="panel-body">
            <asp:Literal runat="server" ID="errorMessage"></asp:Literal>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlOrdersList" CssClass="panel panel-default">
        <div class="panel-heading">Order List</div>
        <asp:GridView runat="server" ID="gvOrdersList" AutoGenerateColumns="false" ShowFooter="false" AllowSorting="true" DataKeyNames="id" OnRowCommand="gvOrdersList_RowCommand">
            <Columns>
                <asp:ButtonField CommandName="View" ImageUrl="~/Images/view.png" HeaderText="View" ButtonType="Image">
                    <ItemStyle CssClass="text-center" />
                </asp:ButtonField>
                <asp:ButtonField CommandName="Print" ImageUrl="~/Images/printer.png" HeaderText="Print" ButtonType="Image">
                    <ItemStyle CssClass="text-center" />
                </asp:ButtonField>
                <asp:ButtonField CommandName="Email" ImageUrl="~/Images/mail.png" HeaderText="Email" ButtonType="Image">
                    <ItemStyle CssClass="text-center" />
                </asp:ButtonField>
                <asp:BoundField DataField="id" HeaderText="Order Number" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                <asp:BoundField DataField="orderDate" HeaderText="Order Date" />
                <asp:BoundField DataField="orderItemCount" HeaderText="Order Item Count" DataFormatString="{0:N0}" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                <asp:BoundField DataField="orderTotal" HeaderText="Order Total" DataFormatString="{0:c}" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                <asp:BoundField DataField="paymentMethodName" HeaderText="Payment Method" />
                <asp:TemplateField HeaderText="Check Info">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="Label6" Text='<%# Eval("checkNumber") %>'></asp:Label><br />
                        <asp:Label runat="server" ID="Label7" Text='<%# Eval("checkDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Payment Information">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="Label1" Text='<%# Eval("cardType") %>'></asp:Label><br />
                        <asp:Label runat="server" ID="Label3" Text='<%# Eval("cardNumberMasked") %>'></asp:Label><br />
                        <asp:Label runat="server" ID="Label5" Text='<%# Eval("authorizationTransactionCode") %>'></asp:Label><br />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="orderStatus" HeaderText="Order Status" />
                <asp:BoundField DataField="paymentStatus" HeaderText="Payment Status" />
            </Columns>
            <EmptyDataTemplate>
                <div class="alert alert-danger">
                    No Orders found for this Devotee.
                </div>
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>
</asp:Content>

