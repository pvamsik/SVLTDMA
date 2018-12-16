<%@ Control Language="C#" AutoEventWireup="true" CodeFile="serviceInfo.ascx.cs" Inherits="Controls_serviceInfo" %>

<asp:Label ID="lblPrinterMsg" runat="server" Visible="false" />
<asp:LinkButton ID="lnkDevInfo" runat="server" OnClick="lnkDevInfo_Click">Go back to Devotee Information</asp:LinkButton>
<div class="service-info">
    <ul>
        <li>
            <label class="lbl-normal">Service Name</label>
            <label class="lbl-bold"><%=serviceRequest.Service_Name %></label>
            
            <label class="lbl-normal">Service Location</label>
            <label class="lbl-bold"><%=serviceRequest.Service_type_description %></label>
        </li>
        <li>
            <label class="lbl-normal">Transaction Date</label>
            <label class="lbl-bold"><%=String.Format("{0:MM/dd/yyyy}", serviceRequest.Created_Date) %></label>
            <label class="lbl-normal">Service Date</label>
            <label class="lbl-bold"><%=String.Format("{0:MM/dd/yyyy}", serviceRequest.Service_Date) %></label>
        </li>
        <li>
            <label class="lbl-normal">Service Fee Paid</label>
            <label class="lbl-bold"><%=String.Format("{0:C}", serviceRequest.Service_Fee_Paid) %></label>
            <label class="lbl-normal">Payment Type</label>
            <label class="lbl-bold"><%=serviceRequest.Payment_type_description %></label>

            <%if (!string.IsNullOrEmpty(serviceRequest.Check_Number))
            { %>
                <label class="lbl-normal">Check Number</label>
                <label class="lbl-bold"><%=serviceRequest.Check_Number %></label>
                <label class="lbl-normal">Check Date</label>
                <label class="lbl-bold"><%=String.Format("{0:MM/dd/yyyy}", serviceRequest.Check_Date) %></label>
            <%} %>
          </li>               
        
        <%if (!string.IsNullOrEmpty(serviceRequest.Status))
          { %>
            <li>
                <label class="lbl-normal">Transaction Status</label>
                <label class="lbl-bold"><%=serviceRequest.Status %></label>
                <% if (serviceRequest.Status != null)
                   { %>
                    <%if ((serviceRequest.Status).Trim() == "Completed")
                      { %>
                    <asp:Button ID="BtnVoidTransaction" runat="server" OnClick="BtnVoidTransaction_Click"
                        Text="Void Transaction" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" />
                    <% } %>
                <% } %>
            </li>
        <%} %>
        <%if (!string.IsNullOrEmpty(serviceRequest.Comment1))
          { %>
            <li>
                <label class="lbl-normal">Comment 1</label>
                <label class="lbl-bold"><%=serviceRequest.Comment1 %></label>
            </li>
        <%  } %>
        <%if (!string.IsNullOrEmpty(serviceRequest.Comment2))
          { %>
            <li>
                <label class="lbl-normal">Comment 2</label>
                <label class="lbl-bold"><%=serviceRequest.Comment2 %></label>
            </li>
        <%  } %>
        <%if (!string.IsNullOrEmpty(serviceRequest.Comment3))
          { %>
            <li>
                <label class="lbl-normal">Comment 3</label>
                <label class="lbl-bold"><%=serviceRequest.Comment3 %></label>
            </li>
        <%  } %>
        <li>
            <%--<asp:Button ID="Print" runat="server" OnClick="Print_Click" Text="Print Receipt" />--%>
            <asp:Button ID="TempleReceipt" runat="server" OnClick="Print_Click" Text="Print Temple Copy" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" />
            <%if (serviceRequest.Payment_type_description == "Credit Card")
              { %>
            <asp:Button ID="MerchantReceipt" runat="server" OnClick="Print_Click" Text="Print Merchant Receipt" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" />
            <asp:Button ID="CustomerReceipt" runat="server" OnClick="Print_Click" Text="Print Customer Receipt" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" />

            <% } %>
            <%if ((serviceRequest.Payment_type_description == "Cash") || (serviceRequest.Payment_type_description == "Check"))
              { %>
            <asp:Button ID="PrintReceipt" runat="server" OnClick="Print_Click" Text="Print Customer Receipt" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" />
            <% } %>
            <asp:Button ID="EmailReceipt" runat="server" OnClick="EmailReceipt_Click" Text="Email Receipt" CssClass="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" />
            <asp:Label ID="lblMessage" runat="server" Visible="false" ForeColor="Red"></asp:Label>
        </li>
    </ul>
</div>
<%if (serviceRequest.Transactions.Any())
  { %>
<div class="service-transactions" id="requesttransactions" runat="server">
    <asp:GridView ID="gvRequestTransactions" runat="server" AutoGenerateColumns="true"
        OnRowDataBound="gvRequestTransactions_RowDataBound">
        <Columns>
            <asp:BoundField DataField="TransactionID" HeaderText="Transaction ID"
                SortExpression="TransactionID" />
            <asp:BoundField DataField="CardType" HeaderText="Card Type"
                SortExpression="CardType" />
            <asp:BoundField DataField="CardNumber" HeaderText="Card Number"
                SortExpression="CardNumber" />
            <asp:BoundField DataField="CardExpiration" HeaderText="Card Expiration"
                SortExpression="CardExpiration" />
            <asp:BoundField DataField="Created_Date" HeaderText="Date"
                SortExpression="Created_Date" />
            <asp:BoundField DataField="TransactionType" HeaderText="Transaction Type"
                SortExpression="TransactionType" />
        </Columns>
    </asp:GridView>
</div>
<%} %>


