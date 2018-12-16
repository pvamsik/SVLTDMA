<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="manageusers.aspx.cs" Inherits="Administration_userSettings" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Controls/ManageUsers.ascx" TagPrefix="uc1" TagName="ManageUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .userLeft
        {
            float: left;
            margin-right: 25px;
        }

        .userRight
        {
            float: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ManageUsers runat="server" ID="ManageUsers" />
</asp:Content>

