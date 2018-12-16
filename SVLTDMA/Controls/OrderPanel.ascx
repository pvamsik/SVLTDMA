<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrderPanel.ascx.cs" EnableTheming="true" Inherits="Controls_OrderPanel" %>

<script>
    $(function () {
        var currentDate = new Date();
        $(".serviceDate").datepicker({
            showOtherMonths: true,
            selectOtherMonths: true
        });
        $(".serviceDate").datepicker("setDate", currentDate);
    });
</script>
<div class="form-horizontal">
    <fieldset>
        <legend>Order Form</legend>
        <div class="form-group">
            <asp:Label runat="server" ID="lblServiceDate" Text="Service Date" CssClass="control-label col-lg-2"></asp:Label>
            <div class="col-lg-10">
                <asp:TextBox runat="server" ID="txtServiceDate" Text="" CssClass="form-control serviceDate"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" ID="lblServiceType" Text="Service Type" CssClass="control-label col-lg-2"></asp:Label>
            <div class="col-lg-10">
                <div class="radio">
                    <label>
                        <asp:RadioButtonList runat="server" ID="rblServiceType" AutoPostBack="True"
                            DataTextField="Service_type_description" DataValueField="Service_Type_ID"
                            OnSelectedIndexChanged="rblServiceType_SelectedIndexChanged">
                        </asp:RadioButtonList>
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" ID="lblService" Text="Service" CssClass="control-label col-lg-2"></asp:Label>
            <div class="col-lg-8">
                <asp:GridView runat="server" ID="gvServiceList" DataKeyNames="Service_ID" AutoGenerateColumns="false"
                    OnRowCommand="gvServiceList_RowCommand" CssClass="table table-striped table-hover">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="Service_ID" HeaderText="Service" ItemStyle-CssClass="col-lg-1">
                            <HeaderStyle CssClass="hidden" />
                            <ItemStyle CssClass="hidden" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Service_Name" HeaderText="Service Name" ItemStyle-CssClass="col-lg-7" />
                        <asp:BoundField DataField="Service_Fee" DataFormatString="{0:c}" HeaderText="Fee" ItemStyle-CssClass="col-lg-1" />
                        <asp:ButtonField CommandName="Buy" ItemStyle-CssClass="col-lg-1" Text="Buy Now" />
                        <asp:ButtonField CommandName="Add" ItemStyle-CssClass="col-lg-2" Text="Add to Cart" />
                    </Columns>
                    <EmptyDataTemplate>
                        No Services found for the selected Date
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
        <div class="col-lg-2"></div>
    </fieldset>
</div>
