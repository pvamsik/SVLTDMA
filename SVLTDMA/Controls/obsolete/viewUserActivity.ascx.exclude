<%@ Control Language="C#" AutoEventWireup="true" CodeFile="viewUserActivity.ascx.cs" EnableTheming="true" Inherits="Controls_viewUserActivity" %>
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

<asp:ValidationSummary ID="searchPanelErrorSummary" runat="server" ShowMessageBox="True" ValidationGroup="Summary" />
<asp:Label runat="server" ID="messages" Text="" />

<asp:Panel ID="searchPanel" runat="server">
    <p>
        <asp:Label ID="lblSearchDate" runat="server" Text="Select Date:" SkinID="frmLabel"></asp:Label>
        <asp:TextBox runat="server" ID="searchDateFrom" CssClass=""></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Search Activity 'From' is required." ControlToValidate="searchDateFrom" SetFocusOnError="True" ValidationGroup="Summary">*</asp:RequiredFieldValidator>
        - 
        <asp:TextBox runat="server" ID="searchDateTo" CssClass=""></asp:TextBox>
        <asp:CalendarExtender TargetControlID="searchDateFrom" runat="server"></asp:CalendarExtender>
        <asp:CalendarExtender TargetControlID="searchDateTo" runat="server"></asp:CalendarExtender>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="Search Activity 'To' is required." ControlToValidate="searchDateTo" ValidationGroup="Summary">*</asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:Label ID="lblSearchName" runat="server" Text="Select User Name:" SkinID="frmLabel"></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="sdsUserActivty" DataTextField="UserName" DataValueField="UserName">
            <asp:ListItem Value="%">Select a name</asp:ListItem>
        </asp:DropDownList>
    </p>
    <p>
        <asp:Button ID="cmdSearchUserActivity" runat="server" Text="View Activity" OnClick="cmdSearchUserActivity_Click" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" ValidationGroup="Summary"></asp:Button>
    </p>
    <p>
        <span>Note: The 'To' date does not include any activity from today. Please select tomorrow's date to include today's activity.</span>
    </p>
</asp:Panel>

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="UserName" DataSourceID="sdsUserActivityByUser">
    <Columns>
        <asp:TemplateField HeaderText="Activity Date">
            <ItemTemplate>
                <asp:Label ID="lblLocalTime" runat="server" Text='<%# Convert.ToDateTime(Eval("ActivityDate")).ToLocalTime().ToString("MM-dd-yyyy hh:mm tt") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="UserName" HeaderText="User Name" SortExpression="UserName" />
        <asp:BoundField DataField="Activity" HeaderText="Activity" SortExpression="Activity" />
        <asp:BoundField DataField="PageUrl" HeaderText="Page Url" SortExpression="PageUrl" />
    </Columns>
    <EmptyDataTemplate>
        The selected User does not have any activity recorded in the system for the Selected Dates. Please search using another date range.
    </EmptyDataTemplate>
</asp:GridView>

<asp:SqlDataSource ID="sdsUserActivityByUser" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
    SelectCommand="SELECT ActivityDate, UserName, Activity, PageUrl FROM UserActivity WHERE convert(date, ActivityDate) >= convert(date, @searchDateFrom) AND convert(date, ActivityDate) <= convert(date, @searchDateTo) AND UserName LIKE @UserName ORDER BY ActivityDate DESC">
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownList1" Name="UserName" PropertyName="SelectedValue" Type="String" DefaultValue="%" />
        <asp:ControlParameter ControlID="searchDateFrom" Name="searchDateFrom" PropertyName="Text" />
        <asp:ControlParameter ControlID="searchDateTo" Name="searchDateTo" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsUserActivty" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="SELECT DISTINCT [UserName] FROM [UserActivity]"></asp:SqlDataSource>

