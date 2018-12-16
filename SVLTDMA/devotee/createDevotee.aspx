<%@ Page Title="Create Devotee" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="createDevotee.aspx.cs" Inherits="devotee_createDevotee" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .pac-container {
            z-index: 20000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well">
        <div id="messages" runat="server"></div>
        <div id="validationSummary" runat="server">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List" ForeColor="#CC0000" />
            <asp:Label ID="lblErrorMsg" runat="server" Text="" Visible="false"></asp:Label>
        </div>
    </div>
    <div class="form-horizontal">
        <asp:Panel runat="server" ID="pnlEditDevotee" CssClass="panel panel-default">
            <div class="panel-heading">Create Devotee</div>
            <div class="panel-body">
                <div class="form-group">
                    <asp:Label ID="Label2" runat="server" Text="Name: (First, Middle, Last):" SkinID="frmLabel" AssociatedControlID="txtFName"></asp:Label>
                    <div runat="server" id="namePanel" class="col-lg-9 form-inline">
                        <asp:DropDownList ID="ddlTitle" runat="server" CssClass="form-control col-lg-1">
                            <asp:ListItem>Select</asp:ListItem>
                            <asp:ListItem>Dr.</asp:ListItem>
                            <asp:ListItem>Mr.</asp:ListItem>
                            <asp:ListItem>Mrs.</asp:ListItem>
                            <asp:ListItem>Ms.</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtFName" runat="server" CssClass="form-control col-lg-1"></asp:TextBox>
                        <asp:TextBox ID="txtMName" runat="server" CssClass="form-control col-lg-1"></asp:TextBox>
                        <asp:TextBox ID="txtLName" runat="server" CssClass="form-control col-lg-1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtFName" runat="server" ErrorMessage="First Name is required" Text="*" Display="Dynamic" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtLName" runat="server" ErrorMessage="Last Name is required" Text="*" Display="Dynamic" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-3" for="autocomplete">Address Lookup:</label>
                    <div class="col-lg-9">
                        <input id="autocomplete" autocomplete="off" placeholder="Enter your address" onfocus="geolocate()" type="text" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label3" runat="server" Text="Address:" AssociatedControlID="txtAddress1" SkinID="frmLabel"></asp:Label>
                    <div class="col-lg-9 form-inline">
                        <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtAddress1" runat="server" ErrorMessage="Address Line 1 is required" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label5" runat="server" Text="City:" SkinID="frmLabel" AssociatedControlID="txtCity"></asp:Label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCityValidator" runat="server" ControlToValidate="txtCity" ErrorMessage="City is required" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label6" runat="server" Text="State:" SkinID="frmLabel" AssociatedControlID="ddlState"></asp:Label>
                    <div class="col-lg-9">
                        <asp:DropDownList ID="ddlState" runat="server" DataSourceID="sqlDSStateProvider"
                            DataTextField="State_Name" DataValueField="State_Code" AppendDataBoundItems="true" CssClass="form-control">
                            <asp:ListItem Text="Select a state" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="ddlState" ErrorMessage="Please select a state" InitialValue="0" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label7" runat="server" Text="Zip:" SkinID="frmLabel" AssociatedControlID="txtZip"></asp:Label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtZip" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtZip" runat="server" ErrorMessage="Zip code is required" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label8" runat="server" Text="Phone:" SkinID="frmLabel" AssociatedControlID="txtPhone1"></asp:Label>
                    <div class="col-lg-9 form-inline">
                        <asp:TextBox ID="txtPhone1" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtPhone1" ErrorMessage="Primary Phone # is required" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtPhone1" ErrorMessage="Invalid Primary Phone Format."
                            Display="Dynamic" ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$">*</asp:RegularExpressionValidator>
                        <asp:TextBox ID="txtPhone2" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtPhone2" ErrorMessage="Invalid Alternate Phone Format."
                            Display="Dynamic" ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$">*</asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label10" runat="server" Text="Email Id:" SkinID="frmLabel" AssociatedControlID="txtEmail1"></asp:Label>
                    <div class="col-lg-9 form-inline">
                        <asp:TextBox ID="txtEmail1" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtEmail1" ErrorMessage="Primary Email is required" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtEmail1" ErrorMessage="Invalid Primary Email Format." Display="Dynamic" ValidationExpression="(\w[-._\w]*\w@\w[-._\w]*\w\.\w{2,3})">*</asp:RegularExpressionValidator>
                        <asp:TextBox ID="txtEmail2" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtEmail2" ErrorMessage="Invalid Alternate Email Format." Display="Dynamic" ValidationExpression="(\w[-._\w]*\w@\w[-._\w]*\w\.\w{2,3})">*</asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-offset-4">
                        <div class="btn-group">
                            <asp:LinkButton ID="cmdCreateDevotee" runat="server" CssClass="btn btn-lg btn-primary" Text="Save Devotee" OnClick="cmdCreateDevotee_Click" />
                            <input id="Button2" type="button" value="Cancel" class="btn btn-lg btn-default" onclick="window.history.back();" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>

    <%--    <asp:TextBoxWatermarkExtender ID="txtAddress1_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="txtAddress1" WatermarkText="Street Name">
    </asp:TextBoxWatermarkExtender>
    <asp:TextBoxWatermarkExtender ID="txtAddress2_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="txtAddress2" WatermarkText="Apt or Suite #">
    </asp:TextBoxWatermarkExtender>
    <asp:TextBoxWatermarkExtender ID="txtCity_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="txtCity" WatermarkText="City">
    </asp:TextBoxWatermarkExtender>
    <asp:TextBoxWatermarkExtender ID="txtFName_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="txtFName" WatermarkText="First Name">
    </asp:TextBoxWatermarkExtender>
    <asp:TextBoxWatermarkExtender ID="txtLName_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="txtLName" WatermarkText="Last Name">
    </asp:TextBoxWatermarkExtender>
    <asp:FilteredTextBoxExtender ID="txtZip_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="txtZip">
    </asp:FilteredTextBoxExtender>
    <asp:FilteredTextBoxExtender ID="txtPhone1_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="txtPhone1" ValidChars="0123456789">
    </asp:FilteredTextBoxExtender>
    <asp:FilteredTextBoxExtender ID="txtPhone2_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="txtPhone2" ValidChars="0123456789">
    </asp:FilteredTextBoxExtender>--%>

    <table id="address" hidden class="">
        <tbody>
            <tr>
                <td class="label">Street address</td>
                <td class="slimField">
                    <input disabled="true" class="field" id="street_number"></td>
                <td class="wideField" colspan="2">
                    <input disabled="true" class="field" id="route"></td>
            </tr>
            <tr>
                <td class="label">City</td>
                <td class="wideField" colspan="3">
                    <input disabled="true" class="field" id="locality"></td>
            </tr>
            <tr>
                <td class="label">State</td>
                <td class="slimField">
                    <input disabled="true" class="field" id="administrative_area_level_1"></td>
                <td class="label">Zip code</td>
                <td class="wideField">
                    <input disabled="true" class="field" id="postal_code"></td>
            </tr>
            <tr>
                <td class="label">Country</td>
                <td class="wideField" colspan="3">
                    <input disabled="true" class="field" id="country"></td>
            </tr>
        </tbody>
    </table>
    <asp:SqlDataSource ID="sqlDSStateProvider" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="SELECT [State Code] AS State_Code, [State Name] AS State_Name FROM [State Code]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDSCreateDevotee" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        InsertCommand="createNewDevotee" InsertCommandType="StoredProcedure" OnInserted="sqlDSCreateDevotee_Inserted"
        SelectCommand="SELECT Devotee_Last_Name, Devotee_First_Name, Devotee_M_Name, Devotee_ID, Devotee_Title, Devotee_Status FROM Devotee WHERE (Devotee_Status = 0)">
        <InsertParameters>
            <asp:Parameter Name="dTitle" Type="String" DefaultValue="" />
            <asp:Parameter Name="dLastName" Type="String" />
            <asp:Parameter Name="dFirstName" Type="String" />
            <asp:Parameter Name="dMiddleName" Type="String" DefaultValue="" />
            <asp:Parameter Name="dPhone1" Type="String" />
            <asp:Parameter Name="dPhone2" Type="String" DefaultValue="" />
            <asp:Parameter Name="dEmail1" Type="String" />
            <asp:Parameter Name="dEmail2" Type="String" DefaultValue="" />
            <asp:Parameter Name="dAddress1" Type="String" />
            <asp:Parameter Name="dAddress2" Type="String" DefaultValue="" />
            <asp:Parameter Name="dCity" Type="String" />
            <asp:Parameter Name="dState" Type="String" />
            <asp:Parameter Name="dZip" Type="String" />
            <asp:Parameter Name="dMessage" Type="int32" Direction="Output" />
            <asp:Parameter Name="dResult" Type="int32" Direction="Output" />
        </InsertParameters>
    </asp:SqlDataSource>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOYlJwdNzuJP8Cx3K3MhjsV9Ipn5ScsI4&libraries=places&callback=initAutocomplete" async="" defer=""></script>
    <script src="<%: ResolveUrl("~/Scripts/googleAddressSearch.js") %>"></script>
</asp:Content>
