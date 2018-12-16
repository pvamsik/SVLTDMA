<%@ Page Title="Site Settings" Language="C#" MasterPageFile="~/admin.master" Theme="Admin" AutoEventWireup="true" CodeFile="siteSettings.aspx.cs" Inherits="Administration_siteSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="form-horizontal">
        <fieldset>
            <legend>Site Settings</legend>
            <div class="form-group">
                <asp:Label runat="server" ID="lblTitle" class="col-lg-2 control-label">Site Title:</asp:Label>
                <div class="col-lg-10">
                    <asp:TextBox ID="txtSiteTitle" CssClass="form-control" runat="server" Text="" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="lblAddress" class="col-lg-2 control-label">Site Address:</asp:Label>
                <div class="col-lg-10">
                    <asp:TextBox ID="txtSiteAddress" CssClass="form-control" runat="server" Text="" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="lblIcon" class="col-lg-2 control-label">Site Icon URL:</asp:Label>
                <div class="col-lg-10">
                    <asp:TextBox ID="txtSiteIcon" CssClass="form-control" runat="server" Text="" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="lblEnvironment" class="col-lg-2 control-label">Production Environment:</asp:Label>
                <div class="col-lg-10">
                    <div class="checkbox">
                        <label>
                            <asp:CheckBox ID="chkEnvironment" runat="server" />
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-10 col-lg-offset-2">
                    <asp:Button runat="server" ID="cmdUpdtSiteSettings" Text="Save Site Settings"
                        OnClick="cmdUpdtSiteSettings_Click"
                        CssClass="btn btn-primary" />
                </div>
            </div>
        </fieldset>
    </div>
</asp:Content>
