<%@ Page Title="Categories" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" Theme="Admin" CodeFile="Index.aspx.cs" Inherits="manage_category_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>Service Types</h3>
    <hr />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/manage/category/Create.aspx" CssClass="btn btn-primary">Create Service Type</asp:HyperLink>
</asp:Content>

