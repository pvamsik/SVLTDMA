<%@ Page Title="Service History" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="devoteeServiceHistory.aspx.cs" Inherits="Devotee_devoteeServiceHistory" %>
<%@ Register Src="~/Controls/ServiceRequestInfo.ascx" TagName="ServiceRequestInfo" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ServiceHistory.ascx" TagPrefix="uc1" TagName="ServiceHistory" %>
<%@ Register Src="~/Controls/DevoteeInformation.ascx" TagPrefix="uc1" TagName="DevoteeInformation" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../Styles/devoteeInfoStyle.css" rel="stylesheet" />
    <link href="../Styles/reqForm.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:DevoteeInformation runat="server" ID="DevoteeInformation" />
    <br />
    <uc1:ServiceHistory runat="server" ID="ServiceHistory" />
</asp:Content>

