<%@ Page Title="Test Page" Theme="kiosk" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Secure_Test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click"
        CssClass="btn btn-primary" Text="Submit Payment" />
</asp:Content>

