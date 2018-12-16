<%@ Control Language="C#" AutoEventWireup="true" CodeFile="serviceList.ascx.cs" Inherits="Controls_serviceList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<p>
    <asp:Label ID="Label1" runat="server" Text="Select Request Date:"></asp:Label><asp:TextBox ID="txtSLSelectedDate" runat="server" AutoPostBack="True"></asp:TextBox>
    <asp:CalendarExtender ID="txtSLSelectedDate_CalendarExtender" runat="server" Enabled="True" TargetControlID="txtSLSelectedDate">
    </asp:CalendarExtender>
</p>
<p>
    <asp:Label ID="Label2" runat="server" Text="Select Location:"></asp:Label>
    <asp:RadioButtonList ID="RadioButtonList1" runat="server" DataSourceID="locationSource" DataTextField="Service_type_description" DataValueField="Service_Type_ID" AutoPostBack="True">
    </asp:RadioButtonList>
</p>
<p>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="Service_ID" DataSourceID="ServicesSource" ForeColor="Black" GridLines="None">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField DataField="Service_ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Service_ID">
                <ItemStyle Width="50px" />
            </asp:BoundField>
            <asp:BoundField DataField="Service_Name" HeaderText="Service" SortExpression="Service_Name">
                <ItemStyle Width="250px" />
            </asp:BoundField>
            <asp:BoundField DataField="Service_Fee" DataFormatString="{0:C}" HeaderText="Fee" SortExpression="Service_Fee">
                <ItemStyle Width="75px" />
            </asp:BoundField>
            <asp:ButtonField Text="Add to Cart" />
        </Columns>
        <FooterStyle BackColor="Tan" />
        <HeaderStyle BackColor="Tan" Font-Bold="True" HorizontalAlign="Left" />
        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
        <SortedAscendingCellStyle BackColor="#FAFAE7" />
        <SortedAscendingHeaderStyle BackColor="#DAC09E" />
        <SortedDescendingCellStyle BackColor="#E1DB9C" />
        <SortedDescendingHeaderStyle BackColor="#C2A47B" />
    </asp:GridView>
</p>


<asp:SqlDataSource ID="locationSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="SELECT [Service_Type_ID], [Service_type], [Service_type_description], [Service_type_Eff_Dt], [Service_type_Exp_Dt] FROM [Service_Type] WHERE (([Service_type_Eff_Dt] &lt;= @Service_type_Eff_Dt) AND ([Service_type_Exp_Dt] &gt;= @Service_type_Exp_Dt))">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtSLSelectedDate" Name="Service_type_Eff_Dt" PropertyName="Text" Type="DateTime" />
        <asp:ControlParameter ControlID="txtSLSelectedDate" Name="Service_type_Exp_Dt" PropertyName="Text" Type="DateTime" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="ServicesSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="SELECT Service_ID, Service_Name, Service_Description, Service_Fee, Service_Type_ID, Service_Status, Service_Effective_Date, Service_Expiration_Date FROM TempleServices WHERE (Service_Effective_Date &lt;= @Service_Effective_Date) AND (Service_Expiration_Date &gt;= @Service_Expiration_Date) AND (Service_Type_ID = @serviceTypeID)">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtSLSelectedDate" Name="Service_Effective_Date" PropertyName="Text" Type="DateTime" />
        <asp:ControlParameter ControlID="txtSLSelectedDate" Name="Service_Expiration_Date" PropertyName="Text" Type="DateTime" />
        <asp:ControlParameter ControlID="RadioButtonList1" Name="serviceTypeID" PropertyName="SelectedValue" />
    </SelectParameters>
</asp:SqlDataSource>

