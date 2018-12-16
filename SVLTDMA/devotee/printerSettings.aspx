<%@ Page Title="Printer Settings" Language="C#" MasterPageFile="~/admin.master" Theme="Admin" AutoEventWireup="true" CodeFile="printerSettings.aspx.cs" Inherits="Administration_printerSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="form-horizontal">
        <fieldset>
            <legend>Client Settings</legend>
            <div class="col-lg-6">
                <div id="messages" runat="server">
                </div>
                <div class="form-group">
                    <asp:Label runat="server" ID="Label1" Text="Client:" CssClass="col-lg-2 control-label" />
                    <label>
                        <asp:Label runat="server" ID="lblName" CssClass="col-lg-10 control-label text-left" Text="" />
                    </label>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" ID="lblClientType" Text="Client Mode:" CssClass="col-lg-2 control-label" />
                    <div class="col-lg-10">
                        <div class="radio">
                            <label>
                                <asp:RadioButtonList runat="server" ID="rblClientType" AutoPostBack="True">
                                    <asp:ListItem Text="Front Desk" Value="Front Desk" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Food Kiosk" Value="Food Kiosk"></asp:ListItem>
                                    <asp:ListItem Text="Service Kiosk" Value="Service Kiosk"></asp:ListItem>
                                </asp:RadioButtonList>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" ID="lblPrinterPort" Text="Printer Port:" CssClass="col-lg-2 control-label" />
                    <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtPrinterPort" Text="" CssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" ID="lblPortSetting" Text="Port Setting:" CssClass="col-lg-2 control-label" />
                    <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtPortSetting" Text="" CssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-8 text-center">
                        <asp:Button runat="server" ID="cmdSavePrinterSettings" Text="Save Settings" OnClick="cmdSavePrinterSettings_Click" CssClass="btn btn-primary" />
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
                    OnRowCommand="GridView1_RowCommand" 
                    DataKeyNames="name" DataSourceID="printerSource">
                    <Columns>
                        <asp:CommandField ShowSelectButton="true" SelectText="Test Print" />
                        <asp:CommandField ShowEditButton="True" />
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="name" HeaderText="Client" ReadOnly="True" SortExpression="name" />
                        <asp:BoundField DataField="port" HeaderText="Printer Port" SortExpression="port" />
                        <asp:BoundField DataField="settings" HeaderText="Printer Settings" SortExpression="settings" />
                        <asp:BoundField DataField="mode" HeaderText="Client Mode" SortExpression="mode" />
                    </Columns>
                </asp:GridView>
            </div>
        </fieldset> 
    </div>
    <asp:Label runat="server" ID="lblPrinterStatus" Text="" />
    <asp:SqlDataSource ID="printerSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        DeleteCommand="printerSettings_DeleteByName"
        InsertCommand="printerSettings_Insert"
        SelectCommand="printerSettings_SelectAll"
        UpdateCommand="printerSettings_UpdateByName" DeleteCommandType="StoredProcedure" InsertCommandType="StoredProcedure" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="name" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="port" Type="String" />
            <asp:Parameter Name="settings" Type="String" />
            <asp:Parameter Name="mode" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="port" Type="String" />
            <asp:Parameter Name="settings" Type="String" />
            <asp:Parameter Name="mode" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

