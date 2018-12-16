<%@ Control Language="C#" AutoEventWireup="true" ViewStateMode="Enabled" EnableViewState="true" CodeFile="quickService.ascx.cs" Inherits="Controls_quickService" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>

<style type="text/css">
    /*td[id^="ContentPlaceHolder1_quickService1_lvServices_ctrl"]
    {
        max-width: 225px;
        min-width: 225px;
        min-height: 75px !important;
    }
    */
    .item-td {
        background: #FFFBD6;
        text-align: center;
        vertical-align: middle;
        color: #333;
        width: 200px;
    }

    .selected-item-td {
        background: #FFCC66;
        text-align: center;
        vertical-align: middle;
        color: #000080;
        width: 200px;
    }

    .lnkbutton {
        padding: 10px;
        text-decoration: none;
    }

        .lnkbutton:hover {
            border: 1px solid #fbcb09;
            background: #fdf5ce url(images/ui-bg_glass_100_fdf5ce_1x400.png) 50% 50% repeat-x;
            font-weight: bold;
            color: #c77405;
        }

    .span-selected {
        padding: 10px;
        width: 80%;
        height: 95%;
        text-decoration: none;
        border: 1px solid #fbcb09;
        background: #fdf5ce url(images/ui-bg_glass_100_fdf5ce_1x400.png) 50% 50% repeat-x;
        font-weight: bold;
        color: #c77405;
    }
</style>

<asp:ValidationSummary ID="ValidationSummary1" runat="server" SkinID="frmErrorValidationSummary" HeaderText="Please fix the following errors:" />
<p>
    <asp:Label ID="lblErrorCC" SkinID="frmErrorLabel" runat="server" Visible="False" Text="For Credit Card, Card Type & Confirmation Number are required." />
    <asp:Label ID="lblErrorCheck" SkinID="frmErrorLabel" runat="server" Visible="False" Text="For Checks, Check Number is required." />
    <asp:Label ID="lblPrinterMsg" SkinID="frmErrorLabel" runat="server" Visible="False" />
    <asp:Label ID="lblAuthorizationError" SkinID="frmErrorLabel" runat="server" Visible="False" />
    <asp:Label ID="lblCCReader" SkinID="frmErrorLabel" runat="server" Visible="False" />
</p>
<asp:UpdatePanel ID="UP_AddService" runat="server">
    <ContentTemplate>
        <p>
            <asp:Label ID="Label1" runat="server" Text="Service Date" SkinID="frmLabel" />
            <asp:TextBox ID="txtServiceDate" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" TargetControlID="txtServiceDate" DaysModeTitleFormat="MM/dd/yyyy" TodaysDateFormat="MM/dd/yyyy"></asp:CalendarExtender>
            <asp:RequiredFieldValidator ID="RFV2" runat="server"
                ControlToValidate="txtServiceDate" ErrorMessage="Please select a Service Date"
                Display="Dynamic">*</asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Service Location" SkinID="frmLabel" />
            <asp:RadioButtonList runat="server" ID="rblLocation" AutoPostBack="True"
                DataTextField="Service_type_description" DataValueField="Service_Type_ID"
                RepeatLayout="Flow" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblLocation_SelectedIndexChanged">
            </asp:RadioButtonList>
            <p>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="Label3" runat="server" SkinID="frmLabel" Text="Service" />
                        <asp:Label ID="lblSelectedService" runat="server" Text="" Visible="false"></asp:Label>
                        <asp:Label ID="lblSelectedServiceName" runat="server" Text=""></asp:Label>
                        $<asp:Label ID="lblSelectedServiceFee" runat="server" Text=""></asp:Label>

                        <%--DataSourceID="SDS_Services" EnablePersistedSelection="true" --%>
                        <asp:GridView ID="gvServices" runat="server" DataKeyNames="Service_ID,Priceeditable"
                            OnSelectedIndexChanging="gvServices_SelectedIndexChanging" OnSelectedIndexChanged="gvServices_SelectedIndexChanged"
                            OnDataBound="gvServices_DataBound" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="20">

                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="Service_Name" HeaderText="Service Name">
                                    <ItemStyle Width="350px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Service_Fee" DataFormatString="$ {0:c}" HeaderText="Fee">
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:ButtonField CommandName="Buy" Text="Buy Now">
                                    <ControlStyle CssClass="ui-button ui-state-default ui-corner-all ui-button-text-only lnkbutton" />
                                </asp:ButtonField>
                                <asp:ButtonField CommandName="Add" Text="Add to Cart">
                                    <ControlStyle CssClass="ui-button ui-state-default ui-corner-all ui-button-text-only lnkbutton" />
                                </asp:ButtonField>
                            </Columns>
                            <EmptyDataTemplate>
                                No Services found for the selected Date
                            </EmptyDataTemplate>
                            <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="rblLocation" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <p>
                    <asp:Label ID="Label4" runat="server" SkinID="frmLabel" Text="Service Fee" />
                    <asp:RequiredFieldValidator ID="rfvServiceFee" runat="server" ControlToValidate="txtServiceFee" Display="Dynamic" ErrorMessage="Service Fee is Required">*</asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="feeValidator" runat="server" ControlToValidate="txtServiceFee" EnableViewState="true"
                        ErrorMessage="Fee must be greater than zero"
                        OnServerValidate="feeValidator_ServerValidate" ValidateEmptyText="true">*</asp:CustomValidator>
                    $<asp:TextBox ID="txtServiceFee" runat="server"></asp:TextBox>
                    <asp:FilteredTextBoxExtender ID="txtServiceFee_FTE" runat="server" Enabled="True" TargetControlID="txtServiceFee" ValidChars="0123456789.">
                    </asp:FilteredTextBoxExtender>
                </p>
                <p>
                    <asp:Label ID="lblPaymentType" runat="server" SkinID="frmLabel" Text="Payment Type" />
                    <asp:RequiredFieldValidator ID="RFV3" runat="server" ControlToValidate="rdlPaymentType" Display="Dynamic" ErrorMessage="Select Payment Type">*</asp:RequiredFieldValidator>
                    <asp:RadioButtonList ID="rdlPaymentType" runat="server" AutoPostBack="true" class="rdl-payment-type" DataTextField="Payment_type_description" DataValueField="Payment_type_ID" OnSelectedIndexChanged="rdlPaymentType_SelectedIndexChanged" RepeatDirection="Horizontal" RepeatLayout="Flow">
                    </asp:RadioButtonList>
                </p>
                <asp:Panel ID="pnlCheck" runat="server" Visible="false">
                    <p>
                        <div class="reqfrmDetailBlock clear tr-credit">
                            <asp:Label ID="lblCheckNumber" runat="server" SkinID="frmLabel" Text="Check Number" />
                            <asp:TextBox ID="txtCheckNumber" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="chkValidator" runat="server" ControlToValidate="txtCheckNumber" EnableViewState="true" ErrorMessage="Please provide Check Number, if payment type is Check" OnServerValidate="chkValidator_ServerValidate" ValidateEmptyText="true">*</asp:CustomValidator>
                        </div>
                        <br />
                        <div class="reqfrmDetailBlock clear tr-credit">
                            <asp:Label ID="lblCheckDate" runat="server" SkinID="frmLabel" Text="Check Date" />
                            <asp:TextBox ID="txtCheckDate" runat="server" CssClass="date"></asp:TextBox>
                            <asp:CalendarExtender ID="date_CalendarExtender" runat="server" Enabled="True" TargetControlID="txtCheckDate" DaysModeTitleFormat="MM/dd/yyyy" TodaysDateFormat="MM/dd/yyyy"></asp:CalendarExtender>
                            <asp:CustomValidator ID="chkDateValidator" runat="server" ControlToValidate="txtCheckDate" EnableViewState="true" ErrorMessage="Please provide Check Date, if payment type is Check" OnServerValidate="chkDateValidator_ServerValidate" ValidateEmptyText="true">*</asp:CustomValidator>
                        </div>
                        </div>
                    </p>
                </asp:Panel>
                <p>
                </p>
                <asp:Panel ID="pnlCard" runat="server" Visible="false">
                    <p>
                        <div class="reqfrmDetailBlock clear tr-credit">
                            <div class="reqfrmDetailLeft">
                                <asp:Label ID="lblCCType" runat="server" SkinID="frmLabel" Text="Credit Card Type" />
                            </div>
                            <asp:CustomValidator ID="cvCCTypeValidator" runat="server" ControlToValidate="rdlCCType" EnableViewState="true" ErrorMessage="Please select a Card Type" OnServerValidate="cvCCTypeValidator_ServerValidate" ValidateEmptyText="true">*</asp:CustomValidator>
                            <div class="reqfrmDetailRight">
                                <asp:RadioButtonList ID="rdlCCType" runat="server" AutoPostBack="true" DataTextField="Credit_card_type_description" DataValueField="Credit_card_type_id" OnSelectedIndexChanged="rdlCCType_SelectedIndexChanged" RepeatDirection="Horizontal">
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="reqfrmDetailBlock clear tr-credit">
                            <p>
                                &nbsp;
                            </p>
                        </div>
                        <div class="reqfrmDetailBlock clear tr-credit">
                            Option 1: Swipe Credit Card below in Swipe Credit Card field to populate the Case Information in Option 2<br />
                            <p>
                                <asp:Label ID="lblmdl" runat="server" SkinID="frmLabel" Text="Swipe Credit Card:" />
                                <asp:TextBox ID="txtCCSwipe" runat="server" AutoPostBack="true" OnTextChanged="txtCCSwipe_TextChanged" />
                            </p>
                        </div>
                        <div class="reqfrmDetailBlock clear tr-credit">
                            or<br />
                        </div>
                        <div class="reqfrmDetailBlock clear tr-credit">
                            Option 2: Manually Enter the Card Information<br />
                            <br />
                            <asp:Label ID="lblCardHolderName" runat="server" SkinID="frmLabel" Text="Card Holder Name" />
                            <asp:TextBox ID="txtCardHolderName" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="cvCardHolderName" runat="server" ControlToValidate="txtCardHolderName" EnableViewState="true" ErrorMessage="Please enter Card Holder Name" OnServerValidate="cvCardHolderName_ServerValidate" ValidateEmptyText="true">*</asp:CustomValidator>
                        </div>
                        <br />
                        <div class="reqfrmDetailBlock clear tr-credit">
                            <asp:Label ID="lblCardNumber" runat="server" SkinID="frmLabel" Text="Card Number" />
                            <asp:TextBox ID="txtCardNumber" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="cvCardNumber" runat="server" ControlToValidate="txtCardNumber" EnableViewState="true" ErrorMessage="Please enter Card Number" OnServerValidate="cvCardNumber_ServerValidate" ValidateEmptyText="true">*</asp:CustomValidator>
                        </div>
                        <br />
                        <div class="reqfrmDetailBlock clear tr-credit">
                            <asp:Label ID="lblCardExpDate" runat="server" SkinID="frmLabel" Text="Card Exp Date" />
                            <asp:DropDownList ID="ddlCCExpMonth" runat="server">
                                <asp:ListItem Value="01">January</asp:ListItem>
                                <asp:ListItem Value="02">February</asp:ListItem>
                                <asp:ListItem Value="03">March</asp:ListItem>
                                <asp:ListItem Value="04">April</asp:ListItem>
                                <asp:ListItem Value="05">May</asp:ListItem>
                                <asp:ListItem Value="06">June</asp:ListItem>
                                <asp:ListItem Value="07">July</asp:ListItem>
                                <asp:ListItem Value="08">August</asp:ListItem>
                                <asp:ListItem Value="09">September</asp:ListItem>
                                <asp:ListItem Value="10">October</asp:ListItem>
                                <asp:ListItem Value="11">November</asp:ListItem>
                                <asp:ListItem Value="12">December</asp:ListItem>
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlCCExpYear" runat="server">
                                <asp:ListItem Value="14">2014</asp:ListItem>
                                <asp:ListItem Value="15">2015</asp:ListItem>
                                <asp:ListItem Value="16">2016</asp:ListItem>
                                <asp:ListItem Value="17">2017</asp:ListItem>
                                <asp:ListItem Value="18">2018</asp:ListItem>
                                <asp:ListItem Value="19">2019</asp:ListItem>
                                <asp:ListItem Value="20">2020</asp:ListItem>
                                <asp:ListItem Value="21">2021</asp:ListItem>
                                <asp:ListItem Value="22">2022</asp:ListItem>
                                <asp:ListItem Value="23">2023</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtCardExpDate" runat="server" Visible="false"></asp:TextBox>
                        </div>
                        <br />
                        <div class="reqfrmDetailBlock clear tr-credit">
                            <asp:Label ID="lblCVVNumber" runat="server" SkinID="frmLabel" Text="Card CVV Number" />
                            <asp:TextBox ID="txtCardCVVNumber" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="cvCVVValidator" runat="server" ControlToValidate="txtCardCVVNumber" EnableViewState="true" ErrorMessage="Please enter Card CVV Number" OnServerValidate="cvCVVValidator_ServerValidate" ValidateEmptyText="true">*</asp:CustomValidator>
                        </div>
                    </p>
                </asp:Panel>
                <br />
                <asp:Panel ID="pnlExtraInfo" runat="server">
                    <p>
                        <asp:Label ID="lblComment1" runat="server" SkinID="frmLabel" Text="Field 1" />
                        <asp:TextBox ID="txtComment1" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </p>
                    <p>
                        <asp:Label ID="lblComment2" runat="server" SkinID="frmLabel" Text="Field 2" />
                        <asp:TextBox ID="txtComment2" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </p>
                    <p>
                        <asp:Label ID="lblComment3" runat="server" SkinID="frmLabel" Text="Field 3" />
                        <asp:TextBox ID="txtComment3" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </p>
                </asp:Panel>
            </p>
        </p>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="rblLocation" EventName="SelectedIndexChanged" />
    </Triggers>
</asp:UpdatePanel>
<p>
    <asp:Button ID="btnAddService" runat="server" Text="Finish" CausesValidation="true"
        CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" OnClick="btnAddService_Click" />
</p>
<asp:SqlDataSource ID="SDS_ServiceLocation" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="GetActiveServiceTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
<asp:SqlDataSource ID="SDS_Services" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="getServicesByServiceType" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="rblLocation" DefaultValue="1" Name="ServiceTypeId" PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SDS_CardType" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="SELECT [Credit_card_type_id], [Credit_card_type_description], [ShowDefault] FROM [Credit_Card_Type]"></asp:SqlDataSource>
