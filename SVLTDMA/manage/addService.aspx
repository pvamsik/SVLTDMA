<%@ Page Title="Add Service" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="addService.aspx.cs" Inherits="manage_addService" %>

<%@ Register src="../Controls/AddService.ascx" tagname="AddService" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:AddService ID="AddService1" runat="server" />
</asp:Content>

