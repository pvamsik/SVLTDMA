<%@ Page Title="Mail Settings" Language="C#" MasterPageFile="~/admin.master" Theme="Admin" AutoEventWireup="true" CodeFile="mailSettings.aspx.cs" Inherits="Administration_mailSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="form-horizontal">
        <fieldset>
            <legend>Mail Settings</legend>
            <div class="form-group">
                <asp:Label runat="server" ID="lblTitle" class="col-lg-2 control-label">Email From:</asp:Label>
                <div class="col-lg-10">
                    <asp:TextBox ID="txtEmailFrm" CssClass="form-control" runat="server" Text="" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="lblAddress" class="col-lg-2 control-label">Sender's User Name:</asp:Label>
                <div class="col-lg-10">
                    <asp:TextBox ID="txtSecurityId" CssClass="form-control" runat="server" Text="" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="lblPassword" class="col-lg-2 control-label">Sender's Password:</asp:Label>
                <div class="col-lg-10">
                    <asp:TextBox ID="txtSecurityPwd" CssClass="form-control" TextMode="Password" runat="server" Text="" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="Label1" class="col-lg-2 control-label">SMTP Server:</asp:Label>
                <div class="col-lg-10">
                    <asp:TextBox ID="txtSMTPServer" CssClass="form-control" runat="server" Text="" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="Label3" class="col-lg-2 control-label">SMTP Port:</asp:Label>
                <div class="col-lg-10">
                    <asp:TextBox ID="txtSMTPPort" CssClass="form-control" runat="server" Text="" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="lblSSLrequired" class="col-lg-2 control-label">SSL Required:</asp:Label>
                <div class="col-lg-10">
                    <div class="radio">
                        <label>
                            <asp:RadioButtonList ID="rblAuthReqd" runat="server" RepeatDirection="Vertical" RepeatLayout="Flow">
                                <asp:ListItem Text="True" Value="true"></asp:ListItem>
                                <asp:ListItem Text="False" Value="false"></asp:ListItem>
                            </asp:RadioButtonList>
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="lblSendEmails" class="col-lg-2 control-label">Send Emails:</asp:Label>
                <div class="col-lg-10">
                    <div class="radio">
                        <label>
                            <asp:RadioButtonList ID="rblSendEmails" runat="server" RepeatDirection="Vertical" RepeatLayout="Flow">
                                <asp:ListItem Text="True" Value="true"></asp:ListItem>
                                <asp:ListItem Text="False" Value="false"></asp:ListItem>
                            </asp:RadioButtonList>
                        </label>
                    </div>
                </div>
            </div>
            <%--                <div class="form-group">
                    <asp:Label runat="server" ID="lblEnvironment" class="col-lg-2 control-label">Production Environment:</asp:Label>
                    <div class="col-lg-10">
                        <div class="checkbox">
                            <asp:CheckBox ID="chkEnvironment" runat="server" />
                        </div>
                    </div>
                </div>--%>
            <div class="form-group">
                <div class="col-lg-10 col-lg-offset-2">
                    <asp:Button runat="server" ID="cmdUpdtMailSettings" Text="Save Mail Settings"
                        OnClick="cmdUpdtMailSettings_Click"
                        CssClass="btn btn-primary" />

                    <asp:Button runat="server" ID="cmdSendTestEmail" Text="Send Test Mail"
                        OnClick="cmdSendTestEmail_Click"
                        CssClass="btn btn-default" />

                </div>
            </div>
        </fieldset>
    </div>
    <asp:Label runat="server" ID="lblResponseMessage" Text="" />
</asp:Content>

