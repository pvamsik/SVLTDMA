<%@ Page Title="Edit Devotee" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="editDevotee.aspx.cs" Inherits="devotee_editdevotee" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /*#locationField, #controls
        {
            position: relative;
            width: 480px;
        }

        #autocomplete
        {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 99%;
        }*/

        .label {
            text-align: right;
            font-weight: bold;
            width: 100px;
            color: #303030;
        }

        #address {
            border: 1px solid #000090;
            background-color: #f0f0ff;
            width: 480px;
            padding-right: 2px;
        }

            #address td {
                font-size: 10pt;
            }

        .field {
            width: 99%;
        }

        .slimField {
            width: 80px;
        }

        .wideField {
            width: 200px;
        }

        #locationField {
            height: 20px;
            margin-bottom: 2px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="form-horizontal">
        <asp:Panel runat="server" ID="pnlEditDevotee" CssClass="panel panel-default">
            <div class="panel-heading">Edit Devotee</div>
            <div class="panel-body">
                <div class="form-group">
                    <div class="col-lg-2"></div>
                    <div class="col-lg-8">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List" ForeColor="#CC0000" />
                        <asp:Label ID="Label4" runat="server" Text="" Visible="false"></asp:Label>
                    </div>
                    <div class="col-lg-2"></div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label2" runat="server" Text="Name: (First, Middle, Last):" SkinID="frmLabel" AssociatedControlID="txtFName"></asp:Label>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtFName" runat="server" ErrorMessage="First Name is required" Text="*" Display="Dynamic" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtLName" runat="server" ErrorMessage="Last Name is required" Text="*" Display="Dynamic" />
                    </div>
                    <div class="col-lg-8 form-inline">
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
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-3" for="autocomplete">Address Lookup:</label>
                    <div class="col-lg-1"></div>
                    <div class="col-lg-8">
                        <input id="autocomplete" autocomplete="off" placeholder="Enter your address" onfocus="geolocate()" type="text" class="form-control"></input>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label1" runat="server" Text="Address:" AssociatedControlID="txtAddress1" SkinID="frmLabel"></asp:Label>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtAddress1" runat="server" ErrorMessage="Address Line 1 is required" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-8 form-inline">
                        <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-margin-bottom xxlarge-width"></asp:TextBox>
                        <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-margin-bottom xxlarge-width" TabIndex="5"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label5" runat="server" Text="City:" AssociatedControlID="txtCity" SkinID="frmLabel"></asp:Label>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCity" ErrorMessage="City is required" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-8">
                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label6" runat="server" Text="State:" AssociatedControlID="ddlState" SkinID="frmLabel"></asp:Label>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="ddlState" ErrorMessage="Please select a state" Display="Dynamic" InitialValue="0">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-8">
                        <asp:DropDownList ID="ddlState" runat="server" DataSourceID="sqlDSStateProvider" CssClass="form-control"
                            DataTextField="State_Name" DataValueField="State_Code" AppendDataBoundItems="true">
                            <asp:ListItem Text="Select a state" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label7" runat="server" Text="Zip:" AssociatedControlID="txtZip" SkinID="frmLabel"></asp:Label>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtZip" runat="server" ErrorMessage="Zip code is required" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-lg-8">
                        <asp:TextBox ID="txtZip" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label8" runat="server" Text="Phone:" AssociatedControlID="txtPhone1" SkinID="frmLabel"></asp:Label>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtPhone1" ErrorMessage="Primary Phone # is required" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtPhone1" Display="Dynamic" ErrorMessage="Please enter a valid Phone Number" ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$">*</asp:RegularExpressionValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtPhone2" Display="Dynamic" ErrorMessage="Please enter a valid Alternate Phone Number" ValidationExpression="^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$">*</asp:RegularExpressionValidator>
                    </div>
                    <div class="col-lg-8 form-inline">
                        <asp:TextBox ID="txtPhone1" runat="server" CssClass="form-control" TabIndex="8"></asp:TextBox>
                        <asp:TextBox ID="txtPhone2" runat="server" CssClass="form-control" TabIndex="9"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label10" runat="server" Text="Email Id:" AssociatedControlID="txtEmail1" SkinID="frmLabel"></asp:Label>
                    <div class="col-lg-1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtEmail1" ErrorMessage="Primary Email is required" Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtEmail1" Display="Dynamic" ErrorMessage="Please enter valid Email" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$">*</asp:RegularExpressionValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtEmail2" Display="Dynamic" ErrorMessage="Please enter valid Alternate Email" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$">*</asp:RegularExpressionValidator>
                    </div>
                    <div class="col-lg-8 form-inline">
                        <asp:TextBox ID="txtEmail1" runat="server" CssClass="form-control" TabIndex="10"></asp:TextBox>
                        <asp:TextBox ID="txtEmail2" runat="server" CssClass="form-control" TabIndex="11"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-offset-4">
                        <div class="btn-group">
                            <asp:Button ID="cmdUpdateDevotee" runat="server" CssClass="btn btn-lg btn-primary" Text="Save Devotee" OnClick="cmdUpdateDevotee_Click" />
                            <asp:Button ID="cmdCancelEdit" runat="server" CssClass="btn btn-lg btn-default" Text="Cancel" OnClick="cmdCancelEdit_Click" />
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-8"></div>
                </div>
            </div>
        </asp:Panel>
        <asp:TextBoxWatermarkExtender ID="txtAddress1_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="txtAddress1" WatermarkText="Street Name">
        </asp:TextBoxWatermarkExtender>
        <asp:TextBoxWatermarkExtender ID="txtAddress2_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="txtAddress2" WatermarkText="Apt or Suite #">
        </asp:TextBoxWatermarkExtender>
        <asp:TextBoxWatermarkExtender ID="txtCity_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="txtCity" WatermarkText="City">
        </asp:TextBoxWatermarkExtender>
        <asp:TextBoxWatermarkExtender ID="txtFName_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="txtFName" WatermarkText="First Name">
        </asp:TextBoxWatermarkExtender>
        <asp:TextBoxWatermarkExtender ID="txtLName_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="txtLName" WatermarkText="Last Name">
        </asp:TextBoxWatermarkExtender>
        <asp:FilteredTextBoxExtender ID="txtPhone2_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="txtPhone2">
        </asp:FilteredTextBoxExtender>
        <asp:FilteredTextBoxExtender ID="txtZip_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="txtZip">
        </asp:FilteredTextBoxExtender>
        <asp:FilteredTextBoxExtender ID="txtPhone1_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="txtPhone1">
        </asp:FilteredTextBoxExtender>
        <p>
            <asp:Label ID="lblErrorMsg" runat="server" Text="" Visible="false"></asp:Label>
        </p>

        <table id="address" hidden="hidden">
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
    </div>
    <asp:SqlDataSource ID="sqlDSStateProvider" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="SELECT [State Code] AS State_Code, [State Name] AS State_Name FROM [State Code]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DevoteeInfo" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="viewDevotee" SelectCommandType="StoredProcedure" UpdateCommand="editDevoteeInformation" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="did" QueryStringField="devoteeId" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="did" Type="Int32" />
            <asp:Parameter Name="dtitle" Type="String" DefaultValue="" />
            <asp:Parameter Name="dmname" Type="String" DefaultValue="" />
            <asp:Parameter Name="dlname" Type="String" />
            <asp:Parameter Name="dfname" Type="String" />
            <asp:Parameter Name="dphone1" Type="String" />
            <asp:Parameter Name="dphone2" Type="String" DefaultValue="" />
            <asp:Parameter Name="demail1" Type="String" />
            <asp:Parameter Name="demail2" Type="String" DefaultValue="" />
            <asp:Parameter Name="dAddress1" Type="String" />
            <asp:Parameter Name="daddress2" Type="String" DefaultValue="" />
            <asp:Parameter Name="dcity" Type="String" />
            <asp:Parameter Name="dstate" Type="String" />
            <asp:Parameter Name="dzip" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:PlaceHolder runat="server">
        <script src="<%: ResolveUrl("~/Scripts/googleAddressSearch.js") %>"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDOYlJwdNzuJP8Cx3K3MhjsV9Ipn5ScsI4&libraries=places&callback=initAutocomplete" async="" defer=""></script>
    </asp:PlaceHolder>
</asp:Content>

