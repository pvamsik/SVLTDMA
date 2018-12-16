<%@ Page Title="Sales" Language="C#" Theme="kiosk" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Kiosk.aspx.cs" Inherits="Secure_Kiosk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <asp:PlaceHolder runat="server">
        <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/jquery.cardswipe.js") %>"></script>
        <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/angular-filter.js") %>"></script>
        <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/newOrder.js") %>"></script>
        <script type="text/javascript" src="<%: ResolveUrl("~/Scripts/angular-uuid2.js") %>"></script>
    </asp:PlaceHolder>
    <style>
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }

        .border-radius-5 {
            border-radius: 5px !important;
        }

        .padding-5 {
            padding: 5px !important;
        }

        .padding-left-0 {
            padding-left: 0px !important;
        }

        .padding-right-0 {
            padding-right: 0px !important;
        }

        .border-radius-20 {
            border-radius: 20px !important;
        }

        .well {
            margin: 5px !important;
            min-height: 30px !important;
        }

        @media (min-width: 768px) {
            .col-sm-4 {
                width: 31.3% !important;
            }

            .service-item .col-sm-5 {
                width: 33.666667% !important;
            }
        }

        @media (max-width: 767px) {
            .col-sm-4 {
                width: 31.3% !important;
            }

            .service-item .col-sm-5 {
                width: 35.666667% !important;
            }
        }

        .right-0 {
            right: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div ng-app="myModule" ng-controller="myController">        
        <div ng-switch="selectionType">
            <div ng-switch-when="serviceSelection">
                <div class="row">
                    <div class="col-sm-8 padding-left-0 padding-right-0">
                        <div id="serviceBox" style="">
                            <div ng-repeat="serviceItem in services|filter:{Service:{Service_Type_ID:5}}" class="well well-sm col-xs-3">
                                <div title="{{serviceItem.Service.Service_Name}}"><label>{{formatName(serviceItem.Service.Service_Name)}}</label></div>
                                <div title="{{serviceItem.Service.Service_Name}}"><label>{{serviceItem.Service.Service_Fee | currency}}</label></div>
                                <div>
                                    <button type="button" class="btn btn-default col-sm-5 border-radius-5" ng-click="addToCart(serviceItem)">
                                        Add &nbsp; <span class="badge service_{{serviceItem.Service.Service_Type_ID}}_{{serviceItem.Service_ID}}">{{getCount(serviceItem.Service_ID)}}</span>
                                    </button>
                                    <button type="button" class="btn btn-default col-sm-5 col-sm-offset-1 border-radius-5" ng-click="removeFromCart(serviceItem)" ng-show="getCount(serviceItem.Service.Service_ID)>0">
                                        Remove
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group" ng-hide="{Service:{Service_Type_ID:5}}">
                            <ul class="nav nav-pills nav-stacked">
                                <li ng-repeat="serviceType in serviceTypes" ng-class="{active: serviceType.Service_Type_ID==5}">
                                    <a ng-click="serviceTypeChanged(serviceType)" class="">{{serviceType.Service_type_description}} 
                                        <span class="badge servicetype_{{serviceType.Service_Type_ID}}">{{getCountServiceType(serviceType)}}</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="form-group" ng-hide="{Service:{Service_Type_ID:5}}">
                            <button type="button" class="btn btn-info border-radius-5" ng-click="selectionTypeChange('paymentSelection')" ng-disabled="invoiceCount==0">
                                Proceed&nbsp;&nbsp; <span class="badge">{{invoiceCount}}</span>&nbsp;&nbsp;<span class="badge total">{{invoiceTotal | currency}}</span>
                            </button>
                        </div>
                        <div class="form-group" id="cartBox">
                            <table class="table table-striped">
                                <thead>
                                    <tr class="label-primary color-white">
                                        <th class="col-sm-5">Service Name</th>
                                        <th class="col-sm-1">Quantity</th>
                                        <th class="col-sm-3">Price</th>
                                        <th class="col-sm-2">Total</th>
                                    </tr>
                                </thead>
                                <tbody ng-init="total = 0">
                                    <tr ng-repeat="cartItem in cartList track by $index">
                                        <td>
                                            <div title="{{cartItem.Service.ServiceDescription}}">
                                                {{cartItem.Service.Service_Name}}
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                            <div class="input-group">
                                                <input id="qty" type="number" class="form-control" readonly name="qty" ng-model="cartItem.Quantity" ng-blur="setTotals(cartItem, true)">
                                            </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="input-group">
                                                <span class="input-group-addon">$</span>
                                                <input id="price" type="number" class="form-control" name="price" 
                                                    ng-model="cartItem.Service.Service_Fee" ng-disabled="!cartItem.Service.PriceEditable" 
                                                    ng-keyup="setTotals()" placeholder="Amount for this Service">
                                            </div>
                                        </td>
                                        <td>
                                            <h5>{{(cartItem.Quantity * cartItem.Service.Service_Fee) | currency}}</h5>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="form-group">
                            <table class="table table-striped">
                                <tfoot>
                                    <tr class="label-warning bold">
                                        <td>Grand Total</td>
                                        <td class="text-right">{{invoiceCount}}</td>
                                        <td>&nbsp;</td>
                                        <td class="text-right">{{invoiceTotal | currency}}</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <div class="form-group">
                            <button class="btn btn-success btn-lg btn-block" ng-click="saveOrderData()" >Pay with Cash</button>
                            <button class="btn btn-primary btn-lg btn-block" ng-click="saveOrderData()" >Pay with Credit Card</button>
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
    </div>
</asp:Content>