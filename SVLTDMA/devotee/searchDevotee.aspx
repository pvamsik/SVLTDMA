<%@ Page Title="Search Devotee" Language="C#" MasterPageFile="~/admin.master" Theme="Admin" AutoEventWireup="true" CodeFile="searchDevotee.aspx.cs" Inherits="devotee_searchDevotee" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel runat="server" ID="searchPanel">
        <div class="panel-heading lead">Search Devotee</div>
        <div class="panel-body form-horizontal">
            <div class="form-group">
                <div class="col-lg-12">
                    <asp:Label ID="lblError" runat="server" Visible="false" Text="Please enter atleast one search criteria."></asp:Label>
                </div>
            </div>
            <div class="form-group col-lg-6">
                <asp:Label ID="lblDevoteeId" runat="server" AssociatedControlID="txtUserId" Text="Devotee Id" SkinID="frmLabel"></asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtUserId" runat="server" Text=""></asp:TextBox>
                </div>
            </div>
            <div class="form-group col-lg-6">
                <asp:Label ID="lblCCSwipe" runat="server" Text="Search by Credit Card" AssociatedControlID="txtCCSwipe" SkinID="frmLabel"></asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtCCSwipe" runat="server" AutoCompleteType="Disabled" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtCCSwipe_TextChanged" />
                </div>
            </div>
            <div class="form-group col-lg-6">
                <asp:Label ID="Label5" runat="server" Text="First Name" AssociatedControlID="txtFName" SkinID="frmLabel"></asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtFName" runat="server" CssClass="form-control"></asp:TextBox>
                    <ajaxToolkit:AutoCompleteExtender ID="txtFName_ACE" runat="server" Enabled="true" TargetControlID="txtFName"
                        DelimiterCharacters="" CompletionSetCount="10" MinimumPrefixLength="2"
                        ServiceMethod="getFirstNames" ServicePath="~/WebServices/myServices.asmx"
                        EnableCaching="false" CompletionInterval="100" FirstRowSelected="false" UseContextKey="True" ContextKey="Name">
                    </ajaxToolkit:AutoCompleteExtender>
                </div>
            </div>
            <div class="form-group col-lg-6">
                <asp:Label ID="Label4" runat="server" Text="Last Name" AssociatedControlID="txtLName" SkinID="frmLabel"></asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtLName" runat="server" CssClass="form-control" AutoCompleteType="LastName"></asp:TextBox>
                    <ajaxToolkit:AutoCompleteExtender ID="txtLName_ACE" runat="server" TargetControlID="txtLName"
                        DelimiterCharacters="" CompletionSetCount="10" MinimumPrefixLength="2"
                        ServiceMethod="getLastNames" ServicePath="~/WebServices/myServices.asmx"
                        EnableCaching="false" CompletionInterval="100" FirstRowSelected="false" UseContextKey="True" ContextKey="LName">
                    </ajaxToolkit:AutoCompleteExtender>
                </div>
            </div>
            <div class="form-group col-lg-6">
                <asp:Label ID="Label3" runat="server" Text="Phone Number" AssociatedControlID="txtPhone" SkinID="frmLabel"></asp:Label>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                    <ajaxToolkit:FilteredTextBoxExtender ID="txtPhone_FTE" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="txtPhone" ValidChars="0123456789">
                    </ajaxToolkit:FilteredTextBoxExtender>
                    <ajaxToolkit:AutoCompleteExtender ID="txtPhone_ACE" runat="server" Enabled="true" TargetControlID="txtPhone"
                        DelimiterCharacters="" CompletionSetCount="10" MinimumPrefixLength="3"
                        ServiceMethod="getPhoneNumbers" ServicePath="~/WebServices/myServices.asmx"
                        EnableCaching="false" CompletionInterval="100" FirstRowSelected="false" UseContextKey="True">
                    </ajaxToolkit:AutoCompleteExtender>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-4 col-lg-8">
                    <div class="btn-group">
                        <asp:Button ID="cmdSearch" runat="server" Text="Search" OnClick="cmdSearch_Click" CssClass="btn btn-lg btn-primary" />
                        <asp:Button ID="cmdCancel" runat="server" Text="Clear Search" OnClick="cmdCancel_Click" CssClass="btn btn-lg btn-default" />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:GridView ID="GridView1" runat="server"
                    DataKeyNames="Devotee_ID" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound"
                    CssClass="panel" AutoGenerateColumns="False">
                    <Columns>
                        <asp:ButtonField CommandName="New" ImageUrl="~/Images/add.png" ButtonType="Image" HeaderText="New Request" Text="Add New Service"></asp:ButtonField>
                        <asp:ButtonField CommandName="List" ImageUrl="~/Images/list.png" ButtonType="Image" HeaderText="Request History" Text="View All Services"></asp:ButtonField>
                        <asp:ButtonField CommandName="Edit" ImageUrl="~/Images/edit.png" ButtonType="Image" HeaderText="Edit Devotee" Text="Edit Devotee Information"></asp:ButtonField>
                        <asp:BoundField HeaderText="First Name" DataField="Devotee_First_Name"
                            SortExpression="Devotee_First_Name"></asp:BoundField>
                        <asp:BoundField HeaderText="Last Name" DataField="Devotee_Last_Name"
                            SortExpression="Devotee_Last_Name"></asp:BoundField>
                        <asp:TemplateField HeaderText="Address">
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Devotee_Address1") %>'></asp:Label><br />
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Devotee_City") %>'></asp:Label>, 
                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("Devotee_State_CD") %>'></asp:Label><br />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phone Number">
                            <ItemTemplate>
                                <asp:Label ID="lblPhone1" runat="server" Text='<%# Eval("Devotee_Phone1") %>'></asp:Label><br />
                                <asp:Label ID="lblPhone2" runat="server" Text='<%# Eval("Devotee_Phone2") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Active?" DataField="Devotee_Status"
                            SortExpression="Devotee_Status"></asp:BoundField>
                        <%--                <asp:TemplateField HeaderText="Family Member">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlFamilyUpdate" runat="server"
                            DataSourceID="SDS_Relations"
                            DataValueField="Relation_ID"
                            DataTextField="Relation_Name"
                            AppendDataBoundItems="true">
                            <asp:ListItem Value="0" Text="Select an Option" />
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                    </Columns>
                    <EmptyDataTemplate>
                        Devotee profile not found. Please
                        <asp:LinkButton runat="server" ID="lnkCreateDevotee" PostBackUrl="~/devotee/createDevotee.aspx">click here</asp:LinkButton>
                        to create a new profile
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </asp:Panel>
    <div class="col-lg-12">
    </div>
    <%--    <p>
        <asp:Button ID="cmdDuplicate" runat="server" Text="Duplicate" Visible="false" CssClass="ui-button ui-state-default ui-corner-all ui-button-text-only" />
        &nbsp;
        <asp:Button ID="cmdFamily" runat="server" Text="Family" Visible="false" OnClick="cmdFamily_Click" CssClass="ui-button ui-state-default ui-corner-all ui-button-text-only" />
    </p>--%>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="SELECT Devotee.Devotee_ID, Devotee.Devotee_Title, Devotee.Devotee_First_Name, Devotee.Devotee_M_Name, Devotee.Devotee_Last_Name, Devotee_Status,
                        Devotee_Contact_Info.Devotee_Phone1, Devotee_Contact_Info.Devotee_Phone2, Devotee_Contact_Info.Devotee_Email1, Devotee_Contact_Info.Devotee_Email2, 
                        Devotee_Mail_Address.Devotee_Mail_Address_ID, Devotee_Mail_Address.Devotee_Address1, Devotee_Mail_Address.Devotee_Address2, Devotee_Mail_Address.Devotee_City, 
                        Devotee_Mail_Address.Devotee_State_CD, Devotee_Mail_Address.Devotee_Zip_CD, Devotee_Contact_Info.Devotee_Contact_Info_ID 
                        FROM Devotee INNER JOIN Devotee_Contact_Info ON Devotee.Devotee_ID = Devotee_Contact_Info.Devotee_ID 
                        INNER JOIN Devotee_Mail_Address ON Devotee_Contact_Info.Devotee_ID = Devotee_Mail_Address.Devotee_ID 
                        Where (Devotee_Contact_Info.Devotee_Phone1 like @phone OR Devotee_Contact_Info.Devotee_Phone2 like @phone)  
                        AND Devotee.Devotee_First_Name like @fname 
                        AND Devotee.Devotee_Last_Name like @lname
                        AND Devotee.Devotee_ID like @devoteeId
                        ORDER BY Devotee_Status ASC">
        <SelectParameters>
            <asp:Parameter Name="phone" DefaultValue="%" />
            <asp:Parameter Name="fname" DefaultValue="%" />
            <asp:Parameter Name="lname" DefaultValue="%" />
            <asp:Parameter Name="devoteeId" DefaultValue="%" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="manageDuplicates" runat="server"
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="select * from Devotee"
        UpdateCommand="UPDATE Devotee SET Devotee_Status = @devoteeStatus WHERE (Devotee_ID = @devoteeId)">
        <UpdateParameters>
            <asp:Parameter Name="devoteeStatus" />
            <asp:Parameter Name="devoteeId" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="manageFamilyMembers" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        InsertCommand="INSERT INTO dbo.Devotee_Relations(Primary_Devotee_ID, Secondary_Devotee_ID, Relation_ID) VALUES (@primarydevoteeid, @secondarydevoteeid, @relationid)"
        SelectCommand="SELECT * FROM devotee_relations">
        <InsertParameters>
            <asp:Parameter Name="primarydevoteeid" />
            <asp:Parameter Name="secondarydevoteeid" />
            <asp:Parameter Name="relationid" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_Relations" runat="server"
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="select * from dbo.Relations"></asp:SqlDataSource>
</asp:Content>

