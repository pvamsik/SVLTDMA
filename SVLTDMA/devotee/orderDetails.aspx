<%@ Page Title="Order Details" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="orderDetails.aspx.cs" Inherits="devotee_orderDetails" %>

<%@ Register Src="~/Controls/DevoteeInformation.ascx" TagPrefix="uc1" TagName="DevoteeInformation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:DevoteeInformation runat="server" ID="DevoteeInformation" />
    <asp:Panel runat="server" ID="pnlErrorMessage" CssClass="panel panel-default">
        <div class="panel-body">
            <div id="messageDiv" runat="server"></div>
            <asp:Literal runat="server" ID="errorMessage"></asp:Literal>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlOrderDetails" CssClass="panel panel-default">
        <div class="panel-heading">Order Details</div>
        <div class="panel-body">
            <div class="form-group text-center">
                <div class="btn-group">
                    <asp:LinkButton runat="server" ID="btnOrdersList" OnClick="btnOrdersList_Click" CssClass="btn btn-default" Text="All Requests" />
                    <asp:LinkButton runat="server" ID="btnPrintOrder" OnClick="btnPrintOrder_Click" CssClass="btn btn-info" Text="Print Receipt" />
                    <asp:LinkButton runat="server" ID="btnEmailOrder" OnClick="btnEmailOrder_Click" CssClass="btn btn-info" Text="Email Receipt" />
                    <asp:LinkButton runat="server" ID="btnRefundOrder" OnClick="btnRefundOrder_Click" CssClass="btn btn-danger" Text="Refund Order" />
                </div>
            </div>
            <asp:Repeater ID="rptOrderDetails" runat="server">
                <ItemTemplate>
                    <div class="form-horizontal panel panel-default">
                        <div class="panel-body">
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-lg-4">Order ID</label>
                                    <asp:Label ID="ID" runat="server" CssClass="col-lg-8" Text='<%#: Eval("Id") %>'></asp:Label>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-4">Payment Type</label>
                                    <asp:Label ID="Label2" runat="server" CssClass="col-lg-8" Text='<%#: Eval("paymentMethodName") %>'></asp:Label>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-lg-4">Order Status</label>
                                    <asp:Label ID="Label1" runat="server" CssClass="col-lg-8" Text='<%#: Eval("orderStatus") %>'></asp:Label>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-4">Payment Status</label>
                                    <asp:Label ID="Label3" runat="server" CssClass="col-lg-8" Text='<%#: Eval("paymentStatus") %>'></asp:Label>
                                </div>
                            </div>
                            <asp:Panel runat="server" ID="CCDetailsPanel" Visible='<%# showCCDetails(Eval("paymentMethodName").ToString()) %>'>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="col-lg-4">Card Name</label>
                                        <asp:Label ID="Label7" runat="server" Text='<%#: Eval("cardName") %>' CssClass="col-lg-8"></asp:Label>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-4">Card Type</label>
                                        <asp:Label ID="Label6" runat="server" Text='<%#: Eval("cardType") %>' CssClass="col-lg-8"></asp:Label>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-4">Card Number</label>
                                        <asp:Label ID="Label8" runat="server" Text='<%#: Eval("cardNumberMasked") %>' CssClass="col-lg-8"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="col-lg-4">Transaction ID</label>
                                        <asp:Label ID="Label4" runat="server" Text='<%#: Eval("authorizationTransactionId") %>' CssClass="col-lg-8"></asp:Label>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-4">Transaction Code</label>
                                        <asp:Label ID="Label5" runat="server" Text='<%#: Eval("authorizationTransactionCode") %>' CssClass="col-lg-8"></asp:Label>
                                    </div>
                                    <div class="form-group"></div>
                                </div>
                            </asp:Panel>
                            <asp:Panel runat="server" ID="Panel1" Visible='<%# showCheckDetails(Eval("paymentMethodName").ToString()) %>'>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="col-lg-4">Check Date</label>
                                        <asp:Label ID="Label9" runat="server" Text='<%#: Eval("checkDate", "{0:d}") %>' CssClass="col-lg-8"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="col-lg-4">Check Number</label>
                                        <asp:Label ID="Label10" runat="server" Text='<%#: Eval("checkNumber") %>' CssClass="col-lg-8"></asp:Label>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:Panel runat="server" ID="commentPanel">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="col-lg-4">Comment 1</label>
                                        <asp:Label ID="Label11" runat="server" Text='<%#: Eval("comment1") %>' CssClass="col-lg-8"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="col-lg-4">Comment 2</label>
                                        <asp:Label ID="Label12" runat="server" Text='<%#: Eval("comment2") %>' CssClass="col-lg-8"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="col-lg-4">Comment 3</label>
                                        <asp:Label ID="Label13" runat="server" Text='<%#: Eval("comment3") %>' CssClass="col-lg-8"></asp:Label>
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:GridView ID="gvOrderItems" runat="server" AutoGenerateColumns="false" AllowSorting="false" ShowFooter="True" OnRowDataBound="gvOrderItems_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="serviceDate" HeaderText="Service date" DataFormatString="{0:d}" SortExpression="serviceDate" />
                    <asp:BoundField DataField="serviceId" HeaderText="Service Id" SortExpression="serviceId" />
                    <asp:BoundField DataField="serviceName" HeaderText="Service Name" SortExpression="serviceName" />
                    <asp:BoundField DataField="quantity" HeaderText="Quantity" DataFormatString="{0:N0}" SortExpression="quantity" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                    <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" DataFormatString="{0:c}" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
                    <asp:BoundField DataField="itemStatus" HeaderText="Status" SortExpression="itemStatus" />
                    <asp:BoundField DataField="comments" HeaderText="Comments" SortExpression="comments" />
                </Columns>
                <FooterStyle Font-Bold="true" />
            </asp:GridView>
        </div>
    </asp:Panel>
</asp:Content>

