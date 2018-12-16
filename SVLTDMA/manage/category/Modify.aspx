<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="Modify.aspx.cs" Inherits="manage_category_Modify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <asp:PlaceHolder runat="server">
        <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/bootstrap-checkbox.js") %>"></script>
    </asp:PlaceHolder>
    <script type="text/javascript">
        $(document).ready(function () {
            $(':checkbox').checkboxpicker();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h3>Modify Service Type</h3>
    <hr />
    <div class="form-horizontal">
        <div class="form-group">
            <asp:Label runat="server" Text="Name" SkinID="frmLabel" AssociatedControlID="txtSTName" />
            <div class="col-lg-9">
                <asp:TextBox runat="server" ID="txtSTName" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" Text="Description" SkinID="frmLabel" AssociatedControlID="txtSTDescription" />
            <div class="col-lg-9">
                <asp:TextBox runat="server" ID="txtSTDescription" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" Text="Effective Date" SkinID="frmLabel" AssociatedControlID="txtSTEffDt" />
            <div class="col-lg-9">
                <asp:TextBox runat="server" ID="txtSTEffDt" TextMode="Date" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" Text="Expiration Date" SkinID="frmLabel" AssociatedControlID="txtSTExpDt" />
            <div class="col-lg-9">
                <asp:TextBox runat="server" ID="txtSTExpDt" TextMode="Date" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" Text="Is Active?" SkinID="frmLabel" AssociatedControlID="chkIsActive"  />
            <div class="col-lg-9">
                <input type="checkbox" runat="server" id="chkIsActive" data-reverse />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" Text="Is Default?" SkinID="frmLabel" AssociatedControlID="chkIsDefault" />
            <div class="col-lg-9">
                <input type="checkbox" runat="server" id="chkIsDefault" data-reverse />
            </div>
        </div>
    </div>
</asp:Content>

