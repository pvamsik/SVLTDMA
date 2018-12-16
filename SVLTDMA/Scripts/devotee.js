$(document).ready(function ($) {

    //getServiceFee();

    $(".print").click(function (event) {

        event.preventDefault();
        event.stopPropagation();

        var qrystr = "serviceRequestDetails.aspx?ajax=true&print=true";
        //alert(qrystr);

        $.get(qrystr, function (data) {
            //alert(data);
            $("#lblPrinterMsg").text(data);
        });
    });

    paymentTypeEnable();

    $(".rdl-payment-type input").click(function (event) {
        paymentTypeEnable();
    });

    function paymentTypeEnable() {

        var v = $(".rdl-payment-type input").is(":checked");

        var paymentType = $(".rdl-payment-type input:checked").val();

        switch (paymentType) {
            case "1":
                //$(".tr-credit").fadeOut(500);
                //$(".tr-check").fadeIn(500);
                $(".tr-credit").hide();
                $(".tr-check").show();

                break;
            case "3":
                //$(".tr-check").fadeOut(500);
                //$(".tr-credit").fadeIn(500);
                $(".tr-check").hide();
                $(".tr-credit").show();
                break;
            default:
                //$(".tr-check").fadeOut(250);
                //$(".tr-credit").fadeOut(250);
                $(".tr-check").hide();
                $(".tr-credit").hide();
                break;
        };

    }

    /*
    
    $(".rdl-service-location input").click(function (event) {
        event.preventDefault();
        event.stopPropagation();

        //alert("hi");

        var selectedId = $(".rdl-service-location input:checked")[0].id;
        var serviceTypeId = $(".rdl-service-location input:checked").val();

        var qrystr = "DevoteeAddService.aspx?ajax=true&islocation=true&servicetypeid=" + serviceTypeId;
        $.get(qrystr, function (data) {
            $(".span-service").html(data);
            $(".txtPaidFee").val($(".hdn-service-fee").val());
            $("#" + selectedId).attr('checked', 'checked');

            $(".ddl-service").unbind('change');
            $(".ddl-service").bind('change', getServiceFee);
        });

    });

    $(".ddl-service").change(getServiceFee);
        
    function getServiceFee(event) {
    
        if (event == undefined) {
            event.preventDefault();
            event.stopPropagation();
        }

        

        var serviceId = $(".ddl-service").val();

        $(".hdn-service-id").val(serviceId);

    
        var qrystr = "DevoteeAddService.aspx?ajax=true&isservice=true&serviceid=" + serviceId;

        $.get(qrystr, function (data) {
            $(".txtPaidFee").val(data);
        });
    }

    
    $(".rdl-payment-type input").click(function (event) {
        paymentTypeEnable();
    });

    function paymentTypeEnable() {

        var v = $(".rdl-payment-type input").is(":checked");
        
        var paymentType = $(".rdl-payment-type input:checked").val();
        
        switch (paymentType) {
            case "1":
                //$(".tr-credit").fadeOut(500);
                //$(".tr-check").fadeIn(500);
                $(".tr-credit").hide();
                $(".tr-check").show();
                
                break;
            case "3":
                //$(".tr-check").fadeOut(500);
                //$(".tr-credit").fadeIn(500);
                $(".tr-check").hide();
                $(".tr-credit").show();
                break;
            default:
                //$(".tr-check").fadeOut(250);
                //$(".tr-credit").fadeOut(250);
                $(".tr-check").hide();
                $(".tr-credit").hide();
                break;
        };
        
    }
    */
});