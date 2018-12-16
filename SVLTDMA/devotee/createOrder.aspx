<%@ Page Title="Create Order" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="createOrder.aspx.cs" Inherits="devotee_createOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../Scripts/jquery.cardswipe.js"></script>
    <script type="text/javascript" src="../Scripts/angular.js"></script>
    <script type="text/javascript" src="../Scripts/angular-filter.js"></script>
    <script type="text/javascript" src="../Scripts/newOrder.js"></script>
    <script type="text/javascript" src="../Scripts/angular-uuid2.js"></script>
    <style>
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div ng-app="myModule" ng-controller="myController">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="panel-title">
                    Select Service
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label class="control-label" for="serviceDate">Service Date:</label>
                            <div class="input-group">
                                <span class="input-group-addon glyphicon glyphicon-calendar"></span>
                                <input class="form-control" type="text" id="serviceDate" name="serviceDate" title="Service Date" />
                            </div>
                        </div>
                        <div class="form-group">
                            <ul class="nav nav-pills nav-stacked">
                                <li ng-repeat="serviceType in serviceTypes" ng-class="{active: serviceType.Service_Type_ID==currentServiceType.Service_Type_ID}">
                                    <a ng-click="serviceTypeChanged(serviceType)" class="">{{serviceType.Service_type_description}} 
                                        <span class="badge servicetype_{{serviceType.Service_Type_ID}}">{{getCountServiceType(serviceType)}}</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-info">
                                Check Out&nbsp;&nbsp; <span class="badge">{{invoiceCount}}</span>&nbsp;&nbsp;<span class="badge total">{{invoiceTotal | currency}}</span>
                            </button>
                        </div>
                    </div>
                    <div class="col-sm-9">
                        <div ng-repeat="serviceItem in services|filter:{Service:{Service_Type_ID:currentServiceType.Service_Type_ID}}" class="well well-sm col-sm-4">
                            <h5>{{formatName(serviceItem.Service.Service_Name)}}</h5>
                            <h6>{{serviceItem.Service.Service_Fee | currency}}</h6>
                            <div>
                                <button type="button" class="btn btn-success col-sm-4" ng-click="addToCart(serviceItem)">
                                    Add&nbsp; <span class="badge service_{{serviceItem.Service.Service_Type_ID}}_{{serviceItem.Service_ID}}">{{getCount(serviceItem.Service_ID)}}</span>
                                </button>
                                <button type="button" class="btn btn-danger col-sm-4 col-sm-offset-1" ng-click="removeFromCart(serviceItem)" ng-show="getCount(serviceItem.Service.Service_ID)>0">
                                    Remove
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr class="label-primary color-white">
                                <th class="col-sm-1">Date</th>
                                <th class="col-sm-3">Service Name</th>
                                <th class="col-sm-3">Quantity</th>
                                <th class="col-sm-2">Price</th>
                                <th class="col-sm-1">Total</th>
                                <th class="col-sm-2">Comment</th>
                            </tr>
                        </thead>
                        <tbody ng-init="total = 0">
                            <tr ng-repeat="cartItem in cartList track by $index">
                                <td>{{cartItem.orderDate}}</td>
                                <td>
                                    <div title="{{cartItem.Service.ServiceDescription}}">
                                        {{cartItem.Service.Service_Name}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-xs-1">
                                        <button type="button" class="btn btn-success" ng-click="addToCart(cartItem, true)" title="Add the Quantity by 1 at a time">Add</button>
                                    </div>
                                    <div class="col-xs-6 col-xs-offset-1">
                                        <input id="qty" type="number" class="form-control" name="qty" ng-model="cartItem.Quantity" ng-blur="setTotals(cartItem, true)">
                                    </div>
                                    <div class="col-xs-1">
                                        <button type="button" class="btn btn-danger" ng-click="removeFromCart(cartItem, true)" title="Remove the Quantity by 1 at a time">Del</button>
                                    </div>
                                </td>
                                <td>
                                    <div class="input-group">
                                        <span class="input-group-addon">$</span>
                                        <input id="price" type="number" class="form-control" name="price" ng-model="cartItem.Service.Service_Fee" ng-disabled="!cartItem.Service.PriceEditable" ng-keyup="setTotals()" placeholder="Amount for this Service">
                                    </div>
                                </td>
                                <td>
                                    <h5>{{(cartItem.Quantity * cartItem.Service.Service_Fee) | currency}}</h5>
                                </td>
                                <td>
                                    <textarea class="form-control" rows="2" id="comment" ng-model="cartItem.Service.comment"></textarea></td>
                            </tr>
                            <tr class="label-warning bold">
                                <td colspan="2">Grand Total</td>
                                <td>{{invoiceCount}}</td>
                                <td>&nbsp;</td>
                                <td>{{invoiceTotal | currency}}</td>
                                <td>&nbsp;</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <div class="col-sm-12 " ng-show="additionalInfoList.length > 0">
                        <label>Below additional information to process this order</label>
                    </div>
                    <div class="col-sm-9">
                        <div class="row">
                            <div class="col-sm-12" ng-repeat="(key, value) in additionalInfoList | orderBy:'Service_Name' | groupBy:'Service_Name'">

                                <div ng-repeat="infoItem in value">
                                    <div ng-if="infoItem.Service_ID == 130">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <label>{{$parent.key}} {{$index+1}}</label></h4>
                                            </div>
                                            <div class="panel-body">
                                                <div class="col-sm-12 padding-left-0">
                                                    <div class="form-group">
                                                        <label for="servicedate">Name:</label>
                                                        <input type="text" class="form-control" ng-model="brickName" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div ng-if="infoItem.Service_ID == 165 || infoItem.Service_ID == 141 || infoItem.Service_ID == 171">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <label>{{$parent.key}} {{$index+1}}</label></h4>
                                            </div>
                                            <div class="panel-body">
                                                <div class="col-sm-4">
                                                    <div class="form-group">
                                                        <label for="servicedate">Date for Seva:</label>
                                                        <input type="text" class="form-control" ng-model="udayaSevaDay" />
                                                    </div>
                                                </div>
                                                <div class="col-sm-4 padding-left-0">
                                                    <div class="form-group">
                                                        <label for="servicedate">Name:</label>
                                                        <input type="text" class="form-control" ng-model="udayaSevaName" />
                                                    </div>
                                                </div>
                                                <div class="col-sm-4">
                                                    <div class="form-group">
                                                        <label for="servicedate">Gothram, Nakshatram etc:</label>
                                                        <textarea class="form-control" rows="3" ng-model="udayaSevaInfo"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <label>Overall comments for this order</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="servicedate">Comment 1:</label>
                                    <textarea class="form-control" rows="3" id="orderComment1" ng-model="orderComment1"></textarea>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="servicedate">Comment 2:</label>
                                    <textarea class="form-control" rows="3" id="orderComment2" ng-model="orderComment2"></textarea>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="servicedate">Comment 3:</label>
                                    <textarea class="form-control" rows="3" id="orderComment3" ng-model="orderComment3"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr />
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#collapse2">
                            <label>Payment Info</label></a></h4>
                    </div>
                    <div class="panel-body">
                        <div class="col-sm-12">
                            <div class="row">
                                <ul class="nav nav-tabs nav-justified">
                                    <li ng-repeat="paymentType in paymentTypes" ng-class="{active: paymentType.Payment_type_ID==currentPaymentType.Payment_type_ID}">
                                        <a ng-click="paymentTypeChanged(paymentType)">{{paymentType.Payment_type_description}}</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="row">
                                <div ng-switch="currentPaymentType.Payment_type_code">
                                    <div class="form-group">
                                        <label for="grandTotal1">Total Amount:</label>
                                        <div class="input-group">
                                            <span class="input-group-addon">$</span>
                                            <input id="grandTotal" type="text" class="form-control" name="grandTotal" ng-model="invoiceTotal" placeholder="Total amount due" ng-disabled="true">
                                        </div>
                                    </div>
                                    <div ng-switch-when="CASH">
                                        <div class="form-group">
                                            <label for="amountTaken" class="control-label">Cash Paid:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon">$</span>
                                                <input type="number" class="form-control" id="amountTaken" name="amountTaken" ng-model="cashPayment" placeholder="Cash Paid">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="amountGiven" class="control-label">Change to return:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon">$</span>
                                                <input type="text" class="form-control" id="amountGiven" name="amountGiven" value="{{calculateChange(cashPayment)}}" ng-disabled="true" placeholder="Change to be returned">
                                            </div>
                                        </div>
                                    </div>
                                    <div ng-switch-when="CHECK">
                                        <div class="form-group">
                                            <label for="amountTaken" class="control-label">Check/Cheque #:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon">Check #</span>
                                                <input type="text" class="form-control" id="checkNo" name="checkNo" ng-model="$parent.checkNo" placeholder="Check/Cheque Number">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="amountGiven" class="control-label">Check/Cheque Date:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon">Check Date</span>
                                                <input type="text" class="form-control" id="checkDate" name="checkDate" ng-model="$parent.checkDate" placeholder="Check/Cheque date">
                                            </div>
                                        </div>
                                        <script>
                                            $(document).ready(function () {
                                                var currentDate = new Date();
                                                $("#checkDate").datepicker({
                                                    showOtherMonths: true,
                                                    selectOtherMonths: true
                                                });
                                                //$("#checkDate").datepicker("setDate", currentDate);
                                            });
                                        </script>
                                    </div>
                                    <div ng-switch-when="CREDIT CARD">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon">Name on the card</span>
                                                <input type="text" class="form-control" id="cardName" name="cardName" ng-model="$parent.cardName" placeholder="Name on the card">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon">Card Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                                <input type="text" class="form-control" id="cardNo" name="cardNo" ng-model="$parent.cardNo" placeholder="Card number">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon">Expiration Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                                <input type="text" class="form-control" id="cardExp" name="cardExp" ng-model="$parent.cardExp" placeholder="Card expiration date">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon">CVV Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                                <input type="text" class="form-control" id="cardCvv" name="cardCvv" ng-model="$parent.cardCvv" placeholder="CVV number">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <button type="button" class="btn btn-primary " ng-click="saveOrderData()" title="Submits the order for processing">Confirm the order</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            // Called by plugin on a successful scan.
            var complete = function (data) {
                // Is it a payment card?
                if (data.type == "generic")
                    return;

                // Copy data fields to form
                $("#cardName").val(data.firstName + " " + data.lastName);
                //$("#lastName").val(data.lastName);
                $("#cardNo").val(data.account);
                $("#cardExp").val(data.expMonth + data.expYear);
                //$("#expYear").val(data.expYear);
                //$("#type").val(data.type);
            };

            // Event handler for scanstart.cardswipe.
            var scanstart = function () {
                $("#overlay").fadeIn(200);
            };

            // Event handler for scanend.cardswipe.
            var scanend = function () {
                $("#overlay").fadeOut(200);
            };

            // Event handler for success.cardswipe.  Displays returned data in a dialog
            var success = function (event, data) {

                $("#properties").empty();

                // Iterate properties of parsed data
                for (var key in data) {
                    if (data.hasOwnProperty(key)) {
                        var text = key + ': ' + data[key];
                        $("#properties").append('<div class="property">' + text + '</div>');
                    }
                }


                $("#success").fadeIn().delay(3000).fadeOut();
            }

            var failure = function () {
                $("#failure").fadeIn().delay(1000).fadeOut();
            }

            // Initialize the plugin with default parser and callbacks.
            //
            // Set debug to true to watch the characters get captured and the state machine transitions
            // in the javascript console. This requires a browser that supports the console.log function.
            //
            // Set firstLineOnly to true to invoke the parser after scanning the first line. This will speed up the
            // time from the start of the scan to invoking your success callback.
            $.cardswipe({
                firstLineOnly: true,
                success: complete,
                parsers: ["visa", "amex", "mastercard", "discover", "generic"],
                debug: false
            });

            // Bind event listeners to the document
            $(document)
                .on("scanstart.cardswipe", scanstart)
                .on("scanend.cardswipe", scanend)
                .on("success.cardswipe", success)
                .on("failure.cardswipe", failure)
            ;

            $(document).ready(function () {
                var currentDate = new Date();
                $("#tabs").tabs();
                $("#serviceDate").datepicker({
                    showOtherMonths: true,
                    selectOtherMonths: true
                });
                $("#serviceDate").datepicker("setDate", currentDate);
                /*
                $("#checkDate").datepicker({
                    showOtherMonths: true,
                    selectOtherMonths: true
                });
                $("#checkDate").datepicker("setDate", currentDate);
                */
            });
        </script>
        <asp:SqlDataSource ID="ServiceTypesList" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="KioskServiceTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
