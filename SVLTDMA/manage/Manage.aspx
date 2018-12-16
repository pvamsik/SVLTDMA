<%@ Page Title="Temple Management" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Manage.aspx.cs" Inherits="manage_Manage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Icon-AddService.png" PostBackUrl="~/manage/AddService.aspx" />
    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Icon-ManageServices.png" PostBackUrl="~/manage/ServiceManager.aspx" />
</asp:Content>

