var myApp = angular.module("myModule", ['angular.filter']);
myApp.controller("myController", function ($scope, $http, $location, filterFilter) {
    
    $scope.serviceNeedsExtraInfo = [130, 165, 141, 171];
    $scope.cartList = [];
    $scope.additionalInfoList = [];  // Service_Type_ID, Service_ID, Name, Gothram, Nakshatram, Rasi, Comment 

    $http.get("/WebServices/myServices.asmx/getServices")
    .then(function (response) {
        //console.log(response);
        $scope.serviceTypes = response.data.ServiceTypes;
        $scope.services = response.data.ServiceList;
        $scope.paymentTypes = response.data.PaymentTypes;
        $scope.creditCardTypes = response.data.CreditCardTypes;
        $scope.serviceTypeChanged();
        $scope.paymentTypeChanged();
        $scope.creditCardTypeChanged();
        //$scope.testPost();
    });

   
    $scope.formatName = function (Service_Name) {
        var sn = Service_Name;
        if (sn.length > 28)
        {
            sn = sn.substring(0, 28) + "...";
        }

        return sn;
    }

    $scope.addToCart = function (serviceItem, fromGrid) {
        var date = $("#serviceDate").val();
        var canAdd = true;
        var addAdditionalInfo;

        angular.forEach($scope.cartList, function (item, key) {
            if (item.Service_ID === serviceItem.Service_ID && ((!fromGrid && item.orderDate == date) || (fromGrid && serviceItem.orderDate == item.orderDate))) {
                item.Quantity++;
                canAdd = false;
                // Adding Additional Needed
                if ($scope.serviceNeedsExtraInfo.indexOf(serviceItem.Service_ID) !== -1) {
                    addAdditionalInfo = item;
                }
                
                return;
            }
        });        
        
        if (canAdd === true)
        {
            var newItem = {
                ItemId: generateUUID(),
                CartId: '',
                dateCreated: new Date(),
                orderDate: date,
                Service_ID: serviceItem.Service_ID,
                Quantity: 1,
                comment: '',
                Service: serviceItem.Service
            };
            $scope.cartList.push(newItem);

            if ($scope.serviceNeedsExtraInfo.indexOf(serviceItem.Service_ID) !== -1) {
                addAdditionalInfo = newItem;
            }            
        }
        
        //$scope.addToTotalAmount(serviceItem.Service.Service_Fee);
        //console.log($scope.cartList);
        $scope.setTotals(serviceItem);

        if (addAdditionalInfo) {
            $scope.addToAdditionalInfo(addAdditionalInfo);
        }
    };

    $scope.addToAdditionalInfo = function (serviceItem) {
        var listCount = filterFilter($scope.additionalInfoList, { Service_ID: serviceItem.Service_ID }, true).length;
        //console.log("listCount - " + listCount);
        for (var v = listCount; v < serviceItem.Quantity; v++) {
            var newInfo = {
                Service_Type_ID: serviceItem.Service.Service_Type_ID,
                Service_ID: serviceItem.Service_ID,
                Service_Name: serviceItem.Service.Service_Name,
                Name: '',
                Gothram: '',
                Nakshatram: '',
                Rasi: '',
                Comment: ''
            }
            $scope.additionalInfoList.push(newInfo);
        }
    }

    $scope.removeFromAdditionalInfo = function (serviceItem, processAddInfo) {
        var list = filterFilter($scope.additionalInfoList, { Service_ID: serviceItem.Service_ID }, true).length;
        var totalCount = $scope.additionalInfoList.length;

        for (var x = totalCount - 1; x >= 0; x--) {            
            console.log("x - " + x);
            if (processAddInfo == true && list == serviceItem.Quantity) {
                return;
            }
            if ($scope.additionalInfoList[x].Service_ID == serviceItem.Service_ID && list >= serviceItem.Quantity) {

                $scope.additionalInfoList.splice(x, 1);
                list--;
                console.log("list - " + list);
                if (!processAddInfo || (processAddInfo == true && list == serviceItem.Quantity)) {
                    return;
                }
            }
        }

        //if (listCount > 0) {
        //    if (temp == 1 && listCount == 1) {
        //        temp = 0;
        //    }
        //    for (var v = listCount; v >= temp; v--) {
        //        console.log("Count - " + v + "   serviceItem.Quantity - " + serviceItem.Quantity + "  listCount -  " + listCount);
        //        $scope.additionalInfoList.splice(v, 1);
        //    }
        //}
    }

    $scope.removeFromCart = function (serviceItem, fromGrid) {
        //$scope.cartList.pop(service);
        var date = $("#serviceDate").val();
        var canRemove = true;
        var contLoop = true;
        var counter;
        var deleteAdditionalInfo;

        angular.forEach($scope.cartList, function (item, key) {
            if (contLoop) {
                counter = key;
                deleteAdditionalInfo = item;
                if (item.Service_ID === serviceItem.Service_ID && ((!fromGrid && item.orderDate == date) || (fromGrid && serviceItem.orderDate == item.orderDate))) {
                    contLoop = false;
                    if (item.Quantity > 1) {
                        item.Quantity--;
                        canRemove = false;

                        if ($scope.serviceNeedsExtraInfo.indexOf(serviceItem.Service_ID) !== -1) {
                            $scope.removeFromAdditionalInfo(deleteAdditionalInfo);
                        }
                        //$scope.substractFromTotalAmount(serviceItem.Service.Service_Fee);
                    }
                    return;
                }
            }
        });
        if (canRemove === true && contLoop === false) {
            $scope.cartList.splice(counter, 1);

            if ($scope.serviceNeedsExtraInfo.indexOf(serviceItem.Service_ID) !== -1) {
                $scope.removeFromAdditionalInfo(deleteAdditionalInfo);
            }
        }

        $scope.setTotals(serviceItem);
    };

    /*$scope.sum = function (items, prop1, prop2, prop3) {
        return items.reduce(function (a, b) {
            return a + (b[prop1] * b[prop2][prop3]);
        }, 0);
    };*/

    $scope.sum = function (items, prop1, prop2, prop3) {
        var tCount = 0;
        var tSum = 0;
        return items.reduce(function (a, b) {
            tSum = tSum + (b[prop1] * b[prop2][prop3]);
        }, 0);
    };

    $scope.invoiceCount = 0;
    $scope.invoiceTotal = 0;
    $scope.setTotals = function (item, processAddInfo) {
        //$(".badge").animate({ color: "blue" });
        //$(".badge").fadeToggle();

        if (item) {
            var srvtype = ".servicetype_" + item.Service.Service_Type_ID;
            var srv = ".service_" + item.Service.Service_Type_ID + "_" + item.Service_ID;
            $(srvtype).animate({ opacity: 0.5 });
            $(srvtype).animate({ opacity: 1 });
            $(srv).animate({ opacity: 0.5 });
            $(srv).animate({ opacity: 1 });
            $(".total").animate({ opacity: 0.5 });
            $(".total").animate({ opacity: 1 });
            
            if (processAddInfo == true && $scope.serviceNeedsExtraInfo.indexOf(item.Service_ID) !== -1) {
                $scope.addToAdditionalInfo(item);
                $scope.removeFromAdditionalInfo(item, processAddInfo);
            }
        }

        
        var tCount = 0;
        var tSum = 0;
        $scope.cartList.reduce(function (a, b) {
            if(b.Quantity) {
                tCount += parseInt(b.Quantity);
            }
            if (b.Quantity && b.Service.Service_Fee) {
                tSum += (parseInt(b.Quantity) * parseInt(b.Service.Service_Fee));
            }
        }, 0);
        $scope.invoiceCount = tCount;
        $scope.invoiceTotal = tSum;
        //$("#card").flip('toggle');
        
        //$(".badge").animate({ color: "red" });
        //$(".badge").animate({ opacity: 1 });
        //$(".badge").fadeToggle();
    };

    $scope.findCount = function (list) {
        var tCount = 0;
        list.reduce(function (a, b) {
            if (b.Quantity) {
                tCount += parseInt(b.Quantity);
            }
        }, 0);
        return tCount;
    }

    $scope.getCount = function (serviceId) {
        var count = $scope.findCount(filterFilter($scope.cartList, { Service_ID: serviceId }, true));
        return count;
    }

    $scope.getCountServiceType = function (serviceTypeItem) {
        //console.log(serviceId);
        //console.log($scope.cartList.length);
        var count = $scope.findCount(filterFilter($scope.cartList, { Service: { Service_Type_ID: serviceTypeItem.Service_Type_ID } }, true));
        //console.log(count);
        //console.log($scope.cartList.length);
        return count;
    }

    //$scope.addToTotalAmount = function (amount) {
    //    $scope.totalAmount += amount
    //};
    //$scope.substractFromTotalAmount = function (amount) {
    //    $scope.totalAmount -= amount
    //};

    $scope.currentServiceType;
    $scope.serviceTypeChanged = function (serviceTypeItem) {
        //alert(serviceTypeItem);
        if (serviceTypeItem) {
            $scope.currentServiceType = serviceTypeItem;
        } else {
            $scope.currentServiceType = filterFilter($scope.serviceTypes, { ShowDefault: true, IsActive: true }, true)[0];
        }
        //console.log($scope.currentServiceType);
    }

    $scope.currentPaymentType;
    $scope.paymentTypeChanged = function (paymentTypeItem) {
        //alert(paymentTypeItem);
        if (paymentTypeItem) {
            $scope.currentPaymentType = paymentTypeItem;
        } else {
            $scope.currentPaymentType = filterFilter($scope.paymentTypes, { ShowDefault: true }, true)[0];
        }
        //console.log($scope.currentPaymentType);
    }
    //$scope.cashPayment = 0;
    $scope.calculateChange = function (cashPayment) {
        if (parseInt($scope.invoiceTotal) != 0 && cashPayment && parseInt(cashPayment) != 0 && cashPayment != "") {
            $scope.changeToReturn = parseInt(cashPayment) - parseInt($scope.invoiceTotal);
        }
        return $scope.changeToReturn;
    }

    $scope.currentCreditCardType;
    $scope.creditCardTypeChanged = function (creditCardTypeItem) {
        //alert(paymentTypeItem);
        if (creditCardTypeItem) {
            $scope.currentCreditCardType = creditCardTypeItem;
        } else {
            $scope.currentCreditCardType = filterFilter($scope.creditCardTypes, { ShowDefault: true }, true)[0];
        }
        //console.log($scope.currentPaymentType);
    }

    function validateRequest() {
        var response = false;

        //Credit Card Validations
        if ($scope.currentPaymentType.Payment_type_code == 'CREDIT CARD' && (!angular.isDefined($scope.cardNo))) {
            alert('Please provide Credit Card Number.');
        }
        if ( $scope.currentPaymentType.Payment_type_code == 'CREDIT CARD' && ( !angular.isDefined($scope.cardName) ) ) {
            alert('Please provide Name as it appears on the Credit Card.');
        }
        if ( $scope.currentPaymentType.Payment_type_code == 'CREDIT CARD' && ( !angular.isDefined($scope.cardExp) ) ) {
            alert('Please provide Credit Card Expiration Month and Year in mmyy format.');
        }
        if ($scope.currentPaymentType.Payment_type_code == 'CREDIT CARD' && (!angular.isDefined($scope.cardCvv))) {
            alert('Please provide Credit Card CVV.');
        }
        if ($scope.currentPaymentType.Payment_type_code == 'CREDIT CARD' &&
            (!angular.isDefined($scope.cardName) || !angular.isDefined($scope.cardNo) || !angular.isDefined($scope.cardExp) || !angular.isDefined($scope.cardCvv))) {
            return true;
        }

        //Check Validations
        if ( $scope.currentPaymentType.Payment_type_code == 'CHECK' && ( !angular.isDefined($scope.checkDate ) ) ) {
            alert('Please provide Check Date.');
        }
        if ($scope.currentPaymentType.Payment_type_code == 'CHECK' && ( !angular.isDefined($scope.checkNo) ) ) {
            alert('Please provide Check Number.'); 
        }
        if ($scope.currentPaymentType.Payment_type_code == 'CHECK' &&
            (!angular.isDefined($scope.checkDate) || !angular.isDefined($scope.checkNo) )) {
            return true;
        }

        //Cart Validation. Must have at least one item selected.
        if ($scope.invoiceCount == 0) {
            alert('Please add at least one service prior to submitting order.');
            return true;
        }
    }

    $scope.saveOrderData = function () {

        var hasErrors = validateRequest();
        if (hasErrors) return;

        var myDevoteeId = $location.search()['devoteeId'];
        var orderedData = {
            DevoteeId: myDevoteeId,
            paymentMethodName: $scope.currentPaymentType.Payment_type_code,
            orderTotal: $scope.invoiceTotal,
            orderItemCount: $scope.invoiceCount,

            //Optional CC Data
            cardName: angular.isDefined($scope.cardName) ? $scope.cardName : '',
            cardNumber: angular.isDefined($scope.cardNo) ? $scope.cardNo : '',
            cardExpiration: angular.isDefined($scope.cardExp) ? $scope.cardExp : '',
            cardCVV2: angular.isDefined($scope.cardCvv) ? $scope.cardCvv : '',

            //Optional Check Data
            checkDate: angular.isDefined($scope.checkDate) ? $scope.checkDate : '',
            checkNumber: angular.isDefined($scope.checkNo) ? $scope.checkNo : '',
            

            orderCreatedBy: 'Vamsi',
            Comment1: angular.isDefined($scope.orderComment1) ? $scope.orderComment1 : "",
            Comment2: angular.isDefined($scope.orderComment2) ? $scope.orderComment2 : "",
            Comment3: angular.isDefined($scope.orderComment3) ? $scope.orderComment3 : "",
            CartList: $scope.cartList
        };

        var req = {
            method: 'POST',
            url: '/WebServices/myServices.asmx/processOrder',
            dataType: 'json',
            headers: {
                "Content-type": 'application/json; charset=utf-8'
            },
            data: { OrderData: orderedData }
        };

        $http(req)
            .then(function (data) {
                var response = angular.fromJson(data);
                if (response.data.resultCode == 1) {
                    window.location.href = '/devotee/orderDetails.aspx?devoteeId=' + orderedData.DevoteeId + '&orderId=' + response.data.orderId;
                } else {
                    alert(response.data.message);
                    console.log(response.data.message);
                }
            }, function (error) {
                var response = angular.fromJson(error);
                alert(response.data.message);
                console.log(response.data.message);
            });
    }
    
    function generateUUID() {
        var d = new Date().getTime();
        var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            var r = (d + Math.random()*16)%16 | 0;
            d = Math.floor(d/16);
            return (c=='x' ? r : (r&0x3|0x8)).toString(16);
        });
        return uuid;
    };


    //Testing Data
    $scope.testPost = function () {
        var req = {
            method: 'POST',
            url: '/WebServices/myServices.asmx/saveData',
            dataType: 'json',
            headers: {
                "Content-type": 'application/json; charset=utf-8'
            },
            data: { test: 'test' }
        };

        /*$http(req)
        .then(function (data) {            
            console.log(data);
            //$scope.creditCardTypeChanged();
        }, function (error) {
            console.log(error);
        });*/

        $http.post("/WebServices/myServices.asmx/saveData", { test: 'test' })
          .success(function (response) {
              console.log(response);

          }, function (error) {
              console.log(error);
          });
    }

    /*
    $http(req)
        .then(function()
        {}), function(){});
    */

});