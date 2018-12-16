<%@ Page Title="Manage Settings" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" Theme="Admin" CodeFile="manageSettings.aspx.cs" Inherits="Administration_manageSettings" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <a href="siteSettings.aspx" target="_self"><span class="flaticon-settings-1"></span></a>


    <asp:ImageButton ID="ibSiteSettings" SkinID="settingsButton" runat="server" PostBackUrl="~/Administration/siteSettings.aspx" ImageUrl="~/Images/general-settings.jpg" />
    
    <asp:ImageButton ID="ibMailSettings" SkinID="settingsButton" runat="server" PostBackUrl="~/Administration/mailSettings.aspx" ImageUrl="~/Images/mail-settings.png" />
    <asp:ImageButton ID="ibUserSettings" SkinID="settingsButton" runat="server" PostBackUrl="~/Administration/userSettings.aspx" ImageUrl="~/Images/user-settings.png" />
</asp:Content>

