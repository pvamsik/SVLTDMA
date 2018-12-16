<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ServiceHistory.ascx.cs" Inherits="Controls_ServiceHistory" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:GridView ID="devoteeServiceHistoryGrid" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="Order_Number" DataSourceID="SDS_ServiceHistory" AllowSorting="True">
            <Columns>
                <asp:ButtonField CommandName="Print" ImageUrl="~/Images/printer.png" ButtonType="Image">
                    <ItemStyle CssClass="text-center" />
                </asp:ButtonField>
                <asp:ButtonField CommandName="View" ImageUrl="~/Images/search.png" ButtonType="Image">
                    <ItemStyle CssClass="text-center" />
                </asp:ButtonField>
                <asp:ButtonField CommandName="Email" ImageUrl="~/Images/mail.png" ButtonType="Image">
                    <ItemStyle CssClass="text-center" />
                </asp:ButtonField>
                <asp:BoundField DataField="Service_Date" HeaderText="Service Date" DataFormatString="{0:MM/dd/yyyy}" SortExpression="Service_Date" />
                <asp:HyperLinkField DataTextField="Order_Number" HeaderText="Order Number" SortExpression="Order_Number"
                    DataNavigateUrlFields="Order_Number" DataNavigateUrlFormatString="~/devotee/serviceRequestDetails.aspx?servicerequestid={0}">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="Service_Name" HeaderText="Service" SortExpression="Service_Name">
                    <ItemStyle />
                </asp:BoundField>
                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                <asp:BoundField DataField="Payment_type_description" HeaderText="Payment Type" SortExpression="Payment_type_description">
                    <ItemStyle />
                </asp:BoundField>
                <asp:BoundField DataField="Fee_Paid" HeaderText="Fee" SortExpression="Fee_Paid" DataFormatString="{0:c}" />
                <asp:BoundField DataField="Check_Number" HeaderText="Check Number" SortExpression="Check_Number" />
                <asp:BoundField DataField="Check_Date" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Check Date" SortExpression="Check_Date" />
                <asp:BoundField DataField="TransactionID" HeaderText="Transaction ID" SortExpression="TransactionID" />
                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
            </Columns>
            <PagerSettings Mode="NumericFirstLast" NextPageText="&amp;gt;   " PreviousPageText="&amp;lt;   " />
        </asp:GridView>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="devoteeServiceHistoryGrid" EventName="PageIndexChanged" />
    </Triggers>
</asp:UpdatePanel>
<%--<asp:SqlDataSource ID="SDS_ServiceHistory" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
    SelectCommand="SELECT Service_Requests.Service_Date, Service_Requests.Service_Request_ID AS [Order Number], Service.Service_Name AS [Service Name], Service_Requests.Service_Fee_Paid, Payment_Type.Payment_type_code FROM Service_Requests INNER JOIN Service ON Service_Requests.Service_ID = Service.Service_ID AND Service_Requests.Service_ID = Service.Service_ID INNER JOIN Payment_Type ON Service_Requests.Payment_Type_ID = Payment_Type.Payment_type_ID AND Service_Requests.Payment_Type_ID = Payment_Type.Payment_type_ID WHERE (Service_Requests.Devotee_ID = @devoteeID) ORDER BY Service_Requests.Service_Date DESC, [Order Number] DESC">
    <SelectParameters>
        <asp:QueryStringParameter Name="devoteeID" QueryStringField="devoteeID" />
    </SelectParameters>
</asp:SqlDataSource>--%>
<asp:SqlDataSource ID="SDS_ServiceHistory" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="GetServiceHistoryofDevotee" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:QueryStringParameter Name="devoteeID" QueryStringField="devoteeID" />

    </SelectParameters>
</asp:SqlDataSource>
<!--asp:SessionParameter Name="role" SessionField="UserRole" Type="String" /-->
