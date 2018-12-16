<%@ Page Title="Create User" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="createuser.aspx.cs" Inherits="manage_createuser" %>

<%@ Register Src="~/Controls/createUser.ascx" TagPrefix="uc1" TagName="createUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:createUser runat="server" ID="createUser" />
</asp:Content>

