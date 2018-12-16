<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ServiceRequestInfo.ascx.cs" Inherits="Controls_ServiceRequestInfo" %>


<asp:Repeater ID="rptrServiceRequests" runat="server" OnItemDataBound="rptrServiceRequests_ItemDataBound">
    <HeaderTemplate></HeaderTemplate>
    <ItemTemplate>
        <div class="service-info">
            <li>
                <label class="lbl-normal">Service Name</label>
                <label class="lbl-bold"><%# ((ServiceRequestDTO)Container.DataItem).Service_Name %></label>
                <label class="lbl-normal">Service Date</label>
                <label class="lbl-bold"><%# ((ServiceRequestDTO)Container.DataItem).Service_Date %></label>
                <label class="lbl-normal">Service Location</label>
                <label class="lbl-bold"><%# ((ServiceRequestDTO)Container.DataItem).Service_type_description %></label>
            </li>            
            <%--<li>
                <label class="lbl-normal">Priest Name</label>
                <label class="lbl-bold"><%# ((Service_Request)Container.DataItem).Priest_Name %></label>
            </li>--%>
            <li>
                <label class="lbl-normal">Service Fee Paid</label>
                <label class="lbl-bold"><%# string.Format("{0:c}", Convert.ToDecimal(((ServiceRequestDTO)Container.DataItem).Service_Fee_Paid)) %></label>
                <label class="lbl-normal">Payment Type</label>
                <label class="lbl-bold"><%# ((ServiceRequestDTO)Container.DataItem).Payment_type_description %></label>
                <%# string.IsNullOrEmpty(((ServiceRequestDTO)Container.DataItem).Check_Number) ? "" : string.Format("<label class=\"lbl-normal\">Check Number</label><label class=\"lbl-bold\">{0}</label>", ((ServiceRequestDTO)Container.DataItem).Check_Number) %>
                
            </li>
            <li>
                <%# string.IsNullOrEmpty(((ServiceRequestDTO)Container.DataItem).Priest_Name) ? "" : string.Format("<label class=\"lbl-normal\">Priest Name</label><label class=\"lbl-bold\">{0}</label>", ((ServiceRequestDTO)Container.DataItem).Priest_Name) %>
                <span><a href="/" rel="/" class="print">Print Receipt</a></span>
            </li>
        </div>
        <div class="service-transactions" id="requesttransactions" runat="server">
        </div>
    </ItemTemplate>
</asp:Repeater>

<asp:GridView ID="gvRequestTransactions" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvRequestTransactions_RowDataBound">
    <Columns>
        <asp:BoundField DataField="TransactionID" HeaderText="Transaction ID"
            SortExpression="TransactionID" />
        <asp:BoundField DataField="RequestedAmount" HeaderText="Requested Amount"
            SortExpression="RequestedAmount" />
        <asp:BoundField DataField="ApprovedAmount" HeaderText="Approved Amount"
            SortExpression="ApprovedAmount" />
        <asp:BoundField DataField="Created_Date" HeaderText="Date"
            SortExpression="Created_Date" />
        <asp:BoundField DataField="IsApproved" HeaderText="Status"
            SortExpression="IsApproved" />
        <asp:TemplateField>
            <ItemTemplate>
                <a href="#" class="void">Void</a>
                <a href="#" class="refund">Refund</a>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>