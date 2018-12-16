<%@ Page Title="Printer Settings" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="printerSettings.aspx.cs" Inherits="Administration_printerSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>Printer Settings</h3>
    <p>
    <asp:Label runat="server" ID="lblPrinterPort" Text="Printer Port:" />
    <asp:TextBox runat="server" ID="txtPrinterPort" Text ="" />
    </p>
    <p>
    <asp:Label runat="server" ID="lblPortSetting" Text="Port Setting:" />
    <asp:TextBox runat="server" ID="txtPortSetting" Text ="" />
    </p>
    <p>
        <asp:DropDownList ID="comboInstalledPrinters" runat="server" Visible="False">
        </asp:DropDownList>
    </p>
    <asp:Button runat="server" ID="cmdSavePrinterSettings" Text="Save Settings" OnClick="cmdSavePrinterSettings_Click" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" />
    <br />
    <asp:Label runat="server" ID="lblPrinterStatus" Text="" />
</asp:Content>

