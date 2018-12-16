<%@ Page Title="Service Manager" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="ServiceManager.aspx.cs" Inherits="manage_ServiceManager" %>
<%@ Register Src="~/Controls/ManageServices.ascx" TagPrefix="uc" TagName="ManageServices" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc:ManageServices runat="server" ID="ManageServices" /> 
</asp:Content>

