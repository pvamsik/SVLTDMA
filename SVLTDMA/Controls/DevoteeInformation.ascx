<%@ Control Language="C#" AutoEventWireup="true" EnableTheming="true" CodeFile="DevoteeInformation.ascx.cs" Inherits="Controls_DevoteeInformation" %>
<asp:FormView ID="devoteeInfo" DataSourceID="SDS_DevoteeInfo" Width="100%" runat="server">
    <ItemTemplate>
        <asp:Panel runat="server" ID="pnlDevoteeInfo">
            <div class="panel-heading lead">
                <asp:Label ID="lblDITitle" runat="server" Text='<%# Eval("devotee_title") %>'></asp:Label>
                <asp:Label ID="lblDIFName" runat="server" Text='<%# Eval("Devotee_first_name") %>'></asp:Label>
                <asp:Label ID="lblDIMName" runat="server" Text='<%# Eval("Devotee_m_name") %>'></asp:Label>
                <asp:Label ID="lblDILName" runat="server" Text='<%# Eval("Devotee_last_name") %>'></asp:Label>
                - 
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Devotee_ID") %>'></asp:Label>
            </div>
            <div class="panel-body">
                <div class="col-lg-3">
                    <asp:Label ID="lblAddress" runat="server" Text="Address:" />
                    <asp:Label ID="lblDIAddress1" runat="server" Text='<%# Eval("devotee_address1") %>'></asp:Label>
                    <asp:Label ID="lblDIAddress2" runat="server" Text='<%# Eval("devotee_address2") %>'></asp:Label><br />
                    <asp:Label ID="lblDICity" runat="server" Text='<%# Eval("devotee_city") %>'></asp:Label>
                    <asp:Label ID="lblDIState" runat="server" Text='<%# Eval("devotee_state_cd") %>'></asp:Label>
                    <asp:Label ID="lblDIZip" runat="server" Text='<%# Eval("devotee_zip_cd") %>'></asp:Label>
                </div>
                <div class="col-lg-3">
                    <asp:Label ID="lblPhone" runat="server" Text="Phone:" />
                    <asp:Label ID="lblDIPhone" runat="server" Text='<%# Eval("devotee_phone1") %>'></asp:Label>
                    <asp:Label ID="lblDIPhone2" runat="server" Text='<%# Eval("devotee_phone2") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lblEmail" runat="server" Text="Email:" />
                    <asp:Label ID="lblDIEmail" runat="server" Text='<%# Eval("devotee_email1") %>'></asp:Label><br />
                    <asp:Label ID="lblDIEmail2" runat="server" Text='<%# Eval("devotee_email2") %>'></asp:Label>
                </div>
                <div class="col-lg-6 text-right">
                    <div class="btn-group">
                        <asp:LinkButton ID="cmdBacktoSearch" CausesValidation="false" runat="server" CssClass="btn btn-default" Text="New Search" OnClick="cmdBacktoSearch_Click" />
                        <asp:LinkButton ID="cmdOrdersList" CausesValidation="false" runat="server" CssClass="btn btn-info" Text="All Requests" OnClick="cmdOrdersList_Click" />
                        <asp:LinkButton ID="cmdNewOrder" CausesValidation="false" runat="server" CssClass="btn btn-info" Text="New Request" OnClick="cmdNewOrder_Click" />
                        <asp:LinkButton ID="cmdEditDevoteeInfo" CausesValidation="false" runat="server" CssClass="btn btn-primary" Text="Modify Devotee" OnClick="cmdEditDevoteeInfo_Click" />
                    </div>
                </div>
            </div>
        </asp:Panel>
    </ItemTemplate>
</asp:FormView>
<asp:SqlDataSource ID="SDS_DevoteeInfo" runat="server"
    ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
    SelectCommand="GetDevoteeInformation" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:QueryStringParameter Name="devoteeID" QueryStringField="devoteeID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
