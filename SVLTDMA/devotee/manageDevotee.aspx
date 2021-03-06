﻿<%@ Page Title="Manage Devotee" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="manageDevotee.aspx.cs" Inherits="devotee_manageDevotee" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Controls/ServiceHistory.ascx" TagPrefix="uc1" TagName="ServiceHistory" %>
<%@ Register Src="~/Controls/quickService.ascx" TagPrefix="uc1" TagName="quickService" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../Styles/devoteeInfoStyle.css" rel="stylesheet" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script>
        $(function () {
            $("#tabs").tabs();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="LoggedOutPanel" runat="server">
    </asp:Panel>
    <asp:Panel ID="LoggedInPanel" runat="server">
        <asp:FormView ID="FormView1" DataSourceID="SDS_DevoteeInfo" runat="server">
            <ItemTemplate>
                <div class="frmDevoteeDetail">
                    <div class="frmDevoteeDetailBlock clear">
                        <div class="frmDevoteeDetailLeft">
                            <asp:Label ID="lblName" runat="server" Text="Name:" SkinID="frmLabel" />
                        </div>
                        <div class="frmDevoteeDetailRight">
                            <asp:Label ID="lblDITitle" runat="server" Text='<%# Eval("devotee_title") %>'></asp:Label>
                            <asp:Label ID="lblDIFName" runat="server" Text='<%# Eval("Devotee_first_name") %>'></asp:Label>
                            <asp:Label ID="lblDIMName" runat="server" Text='<%# Eval("Devotee_m_name") %>'></asp:Label>
                            <asp:Label ID="lblDILName" runat="server" Text='<%# Eval("Devotee_last_name") %>'></asp:Label>
                        </div>
                    </div>
                    <div class="frmDevoteeDetailBlock clear">
                        <div class="frmDevoteeDetailLeft">
                            <asp:Label ID="lblPhone" runat="server" Text="Phone:" SkinID="frmLabel" />
                        </div>
                        <div class="frmDevoteeDetailRight">
                            <asp:Label ID="lblDIPhone" runat="server" Text='<%# Eval("devotee_phone1") %>'></asp:Label><br />
                            <asp:Label ID="lblDIPhone2" runat="server" Text='<%# Eval("devotee_phone2") %>'></asp:Label>
                        </div>
                    </div>
                    <div class="frmDevoteeDetailBlock clear">
                        <div class="frmDevoteeDetailLeft">
                            <asp:Label ID="lblEmail" runat="server" Text="Email:" SkinID="frmLabel" />
                        </div>
                        <div class="frmDevoteeDetailRight">
                            <asp:Label ID="lblDIEmail" runat="server" Text='<%# Eval("devotee_email1") %>'></asp:Label><br />
                            <asp:Label ID="lblDIEmail2" runat="server" Text='<%# Eval("devotee_email2") %>'></asp:Label>
                        </div>
                    </div>
                    <div class="frmDevoteeDetailBlock clear">
                        <div class="frmDevoteeDetailLeft">
                            <asp:Label ID="lblAddress" runat="server" Text="Address:" SkinID="frmLabel" />
                        </div>
                        <div class="frmDevoteeDetailRight">
                            <asp:Label ID="lblDIAddress1" runat="server" Text='<%# Eval("devotee_address1") %>'></asp:Label>
                            <asp:Label ID="lblDIAddress2" runat="server" Text='<%# Eval("devotee_address2") %>'></asp:Label><br />
                            <asp:Label ID="lblDICity" runat="server" Text='<%# Eval("devotee_city") %>'></asp:Label>&#44;
                        <asp:Label ID="lblDIState" runat="server" Text='<%# Eval("devotee_state_cd") %>'></asp:Label>
                            <asp:Label ID="lblDIZip" runat="server" Text='<%# Eval("devotee_zip_cd") %>'></asp:Label>
                        </div>
                    </div>
                </div>
                <br />
                <p>
                    <asp:Button ID="cmdEditDevoteeInfo" CausesValidation="false" runat="server" CssClass="ui-button ui-state-default ui-corner-all ui-button-text-only" Text="Modify Devotee Information" OnClick="cmdEditDevoteeInfo_Click" />
                    <asp:Button ID="cmdCancel" CausesValidation="false" runat="server" CssClass="ui-button ui-state-default ui-corner-all ui-button-text-only" Text="Back to Search" OnClick="cmdCancel_Click" />
                </p>
            </ItemTemplate>
        </asp:FormView>
        <div id="tabs">
            <ul>
                <li><a href="#tab1">Add Service</a></li>
                <li><a href="#tab2">Service History</a></li>
                <li><a href="#tab3">Family Members</a></li>
                <li><a href="#tab4">Duplicates</a></li>
            </ul>
            <div id="tab1">
                <p>
                    <uc1:quickService runat="server" ID="quickService" />
                </p>
            </div>
            <div id="tab2">
                <p>
                   <uc1:ServiceHistory runat="server" ID="ServiceHistory" />
<!-- BEGIN Mohan  

<asp:GridView ID="devoteeServiceHistoryGrid" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="Order_Number" DataSourceID="SDS_ServiceHistory0" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="Service_Date" HeaderText="Service Date" DataFormatString="{0:MM/dd/yyyy}" SortExpression="Service_Date">
                </asp:BoundField>
                <asp:HyperLinkField DataTextField="Order_Number" HeaderText="Order Number" SortExpression="Order_Number" 
                    DataNavigateUrlFields="Order_Number" DataNavigateUrlFormatString="~/devotee/serviceRequestDetails.aspx?servicerequestid={0}">
                    <ItemStyle HorizontalAlign="Center" Width="150px" />
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="Service_Name" HeaderText="Service" SortExpression="Service_Name">
                    <ItemStyle Width="225px" />
                </asp:BoundField>
                <asp:BoundField DataField="Payment_type_description" HeaderText="Payment Type" SortExpression="Payment_type_description">
                    <ItemStyle Width="75px" />
                </asp:BoundField>
                <asp:BoundField DataField="Fee_Paid" HeaderText="Fee" SortExpression="Fee_Paid" DataFormatString="{0:c}" />
                <asp:BoundField DataField="Check_Number" HeaderText="Check Number" SortExpression="Check_Number" />
                <asp:BoundField DataField="Check_Date" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Check Date" SortExpression="Check_Date" />
                <asp:BoundField DataField="TransactionID" HeaderText="Transaction ID" SortExpression="TransactionID" />
            </Columns>
            <PagerSettings Mode="NumericFirstLast" NextPageText="&amp;gt;   " PreviousPageText="&amp;lt;   " />
        </asp:GridView>
 END Mohan -->


                </p>
            </div>
            <div id="tab3">
                <p>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="familyDataSource">
                        <Columns>
                            <asp:TemplateField HeaderText="Name" SortExpression="devfm_fname">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("devfm_fname") %>'></asp:Label>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("devfm_lname") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="devfm_relation" HeaderText="Relation" SortExpression="devfm_relation" />
                        </Columns>
                        <EmptyDataTemplate>
                            No Family Member&#39;s have been registered yet!!!
                        </EmptyDataTemplate>
                    </asp:GridView>
                </p>
            </div>
            <div id="tab4">
                <p>
                    <asp:GridView ID="GrdDuplicateManager" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="Devotee_ID" DataSourceID="DevoteeDuplicateManager" OnRowCommand="GrdDuplicateManager_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Devotee_ID" HeaderText="Devotee ID" SortExpression="Devotee_ID" />
                            <asp:TemplateField HeaderText="Name">
                                <HeaderTemplate>
                                    Possible Duplicate Devotees
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Devotee_Title") %>'></asp:Label>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("Devotee_First_Name") %>'></asp:Label>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("Devotee_Last_Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnDuplicate" Text="Duplicate" runat="server"
                                        CssClass="ui-button ui-state-default ui-corner-all ui-button-text-only"
                                        CommandArgument='<%# Eval("Devotee_ID") %>' CommandName="Duplicate" OnClientClick="return confirm('Are you sure you want to mark this user as duplicate. This action cannot be reversed?');"></asp:Button>

                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            No duplicate Devotee profiles found!!!
                        </EmptyDataTemplate>
                    </asp:GridView>
                </p>
            </div>
        </div>





    </asp:Panel>
    <asp:SqlDataSource ID="DevoteeDuplicateManager" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="viewDevoteeDuplicates" SelectCommandType="StoredProcedure" UpdateCommand="setDuplicateDevotees" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="did" QueryStringField="devoteeId" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="didOriginal" Type="Int32" />
            <asp:Parameter Name="didNew" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="familyDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT [devfm_fname], [devfm_mname], [devfm_lname], [devfm_relation], [devfm_relation_status] FROM [Devotee_Relation] WHERE ([devotee_id] = @devotee_id)">
        <SelectParameters>
            <asp:QueryStringParameter Name="devotee_id" QueryStringField="devoteeId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_DevoteeInfo" runat="server"
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT Devotee.Devotee_Title, Devotee.Devotee_M_Name, Devotee.Devotee_First_Name, Devotee.Devotee_Last_Name, Devotee_Contact_Info.Devotee_Contact_Info_ID, Devotee_Contact_Info.Devotee_Phone1, Devotee_Contact_Info.Devotee_Phone2, Devotee_Contact_Info.Devotee_Email1, Devotee_Contact_Info.Devotee_Email2, Devotee_Mail_Address.Devotee_Mail_Address_ID, Devotee_Mail_Address.Devotee_Address1, Devotee_Mail_Address.Devotee_Address2, Devotee_Mail_Address.Devotee_City, Devotee_Mail_Address.Devotee_State_CD, Devotee_Mail_Address.Devotee_Zip_CD FROM Devotee INNER JOIN Devotee_Contact_Info ON Devotee.Devotee_ID = Devotee_Contact_Info.Devotee_ID INNER JOIN Devotee_Mail_Address ON Devotee_Contact_Info.Devotee_ID = Devotee_Mail_Address.Devotee_ID WHERE (Devotee.Devotee_ID = @id)">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="devoteeId" />
        </SelectParameters>
    </asp:SqlDataSource>


<asp:SqlDataSource ID="SDS_ServiceHistory0" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
    SelectCommand="GetServiceHistoryofDevotee" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:QueryStringParameter Name="devoteeID" QueryStringField="devoteeId" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>

