<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddService.ascx.cs" EnableTheming="true" Inherits="Controls_AddService" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<style>
    p {
        padding-top: 10px;
    }

    .watermarked {
        padding: 2px 0 0 2px;
        border: 1px solid #BEBEBE;
        background-color: #F0F8FF;
        color: gray;
    }
</style>
<script>
    $(document).ready(function () {
        $(".buttonset").buttonset();
    });
</script>
<script type="text/javascript" src="../Scripts/bootstrap.js"></script>
<link type="text/css" href="../Styles/bootstrap.min.css" rel="stylesheet" />

<asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />
<asp:Label runat="server" ID="messages" Text="" />
<fieldset class="form-horizontal">
    <legend>Create new Service</legend>
    <div class="form-group">
        <asp:Label ID="Label1" runat="server" Text="Service Name" AssociatedControlID="txtServiceName" SkinID="frmLabel"></asp:Label>
        <div class="col-lg-9">
            <asp:TextBox ID="txtServiceName" placeholder="Service Name" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtServiceName" ErrorMessage="Please enter Service Name">*</asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label2" runat="server" Text="Service Description" AssociatedControlID="txtServiceDescription" SkinID="frmLabel"></asp:Label>
        <div class="col-lg-9">
            <asp:TextBox ID="txtServiceDescription" placeholder="Service Description" runat="server" MaxLength="1000"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtServiceDescription" ErrorMessage="Please enter Service Description">*</asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label3" runat="server" Text="Service Fee" AssociatedControlID="txtServiceFee" SkinID="frmLabel"></asp:Label>
        <div class="col-lg-9">
            <asp:TextBox ID="txtServiceFee" placeholder="Service Fee" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtServiceFee" ErrorMessage="Please enter Service Fee">*</asp:RequiredFieldValidator>
            <asp:FilteredTextBoxExtender ID="txtServiceFee_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="txtServiceFee" ValidChars="."></asp:FilteredTextBoxExtender>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label4" runat="server" Text="Service Location" AssociatedControlID="rblServiceLocation" SkinID="frmLabel"></asp:Label>
        <div class="col-lg-9">
            <div class="radio">
                <asp:RadioButtonList ID="rblServiceLocation" runat="server" CssClass="rdl-service-location"
                    DataSourceID="sdsServiceTypes" DataTextField="Service_type_description"
                    DataValueField="Service_Type_ID" RepeatLayout="UnorderedList">
                </asp:RadioButtonList>
            </div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rblServiceLocation" ErrorMessage="Please select Service Location">*</asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label6" runat="server" Text="Price Editable" AssociatedControlID="chkPriceEditable" SkinID="frmLabel"></asp:Label>
        <div class="col-lg-9">
            <div class="checkbox">
                <asp:CheckBox runat="server" ID="chkPriceEditable" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-lg-2"></div>
        <asp:Button ID="cmdCreate" runat="server" Text="Add Service" CssClass="btn btn-lg btn-primary" OnClick="cmdCreate_Click" />
    </div>
</fieldset>

<asp:SqlDataSource ID="sdsServiceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="GetServiceTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
<asp:SqlDataSource ID="sdsInsertService" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="GetServices" SelectCommandType="StoredProcedure"
    InsertCommand="Service_Insert" InsertCommandType="StoredProcedure" OnInserted="sdsInsertService_Inserted">
    <InsertParameters>
        <asp:Parameter Name="serviceName" Type="String" />
        <asp:Parameter Name="serviceDescription" Type="String" />
        <asp:Parameter Name="serviceFee" Type="Decimal" />
        <asp:Parameter Name="serviceTypeID" Type="Int32" />
        <asp:Parameter Name="result" Type="Int32" Direction="Output" />
    </InsertParameters>
</asp:SqlDataSource>



