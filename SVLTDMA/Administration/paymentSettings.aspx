<%@ Page Title="Payment Settings" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="paymentSettings.aspx.cs" Inherits="Administration_paymentSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(function () {
            $("#tabs").tabs();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel runat="server" ID="pnlPaymentSettings" CssClass="panel panel-default">
        <div class="panel-heading">Payment Settings - Authorize.Net</div>
        <div class="panel-body">
            <div class="form-horizontal">
                <div id="tabs">
                    <ul>
                        <li><a href="#tab1">Card Present</a></li>
                        <li><a href="#tab2">Card Not Present</a></li>
                    </ul>
                    <div id="tab1">
                        <div class="form-group">
                            <asp:Label runat="server" ID="lblAuthorizeNetLogin" AssociatedControlID="txtAuthorizeNetCPLogin" SkinID="frmLabel" Text="Login"></asp:Label>
                            <div class="col-lg-9">
                                <asp:TextBox ID="txtAuthorizeNetCPLogin" runat="server" Text="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="lblAuthorizeNetTransactionKey" AssociatedControlID="txtAuthorizeNetCPTransactionKey" SkinID="frmLabel" Text="Transaction Key"></asp:Label>
                            <div class="col-lg-9">
                                <asp:TextBox ID="txtAuthorizeNetCPTransactionKey" runat="server" Text="" />
                            </div>
                        </div>
                    </div>
                    <div id="tab2">
                        <div class="form-group">
                            <asp:Label runat="server" ID="lblAuthorizeNetLoginCNP" AssociatedControlID="txtAuthorizeNetCNPLogin" SkinID="frmLabel" Text="Login"></asp:Label>
                            <div class="col-lg-9">
                                <asp:TextBox ID="txtAuthorizeNetCNPLogin" runat="server" Text="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="lblAuthorizeNetTransactionKeyCNP" AssociatedControlID="txtAuthorizeNetCNPTransactionKey" SkinID="frmLabel" Text="Transaction Key"></asp:Label>
                            <div class="col-lg-9">
                                <asp:TextBox ID="txtAuthorizeNetCNPTransactionKey" runat="server" Text="" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" ID="lblAuthorizeNetIsTest" AssociatedControlID="cbAuthorizeNetIsTest" SkinID="frmLabel" Text="Test Mode"></asp:Label>
                    <div class="col-lg-9">
                        <div class="checkbox">
                            <asp:CheckBox ID="cbAuthorizeNetIsTest" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Button ID="cmdUpdtPaymentSettings" runat="server" OnClick="cmdUpdtPaymentSettings_Click" Text="Save Payment Settings" CssClass="btn btn-primary col-lg-offset-3" />
            </div>
        </div>
    </asp:Panel>

    <asp:BulletedList ID="resp" runat="server" BulletStyle="UpperAlpha">
    </asp:BulletedList>
</asp:Content>

