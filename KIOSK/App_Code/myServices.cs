using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using CommonDTO;
using CommonDTO.Entities;
using CreditCardValidator;
using System.Data.Entity.Validation;

/// <summary>
/// A collection of Webservices provided by DMA Application
/// </summary>

[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class myServices : System.Web.Services.WebService
{
    [WebMethod]
    public void getServices()
    {
        JavaScriptSerializer js = new JavaScriptSerializer();
        Data _data = new Data();

        List<ServiceTypeDTO> _serviceTypes = _data.GetServiceTypes();
        List<ServiceDTO> _services = _data.GetServices();
        List<PaymentTypeDTO> _paymentTypes = _data.GetPaymentTypes();
        List<CreditCardTypeDTO> _creditCardTypes = _data.GetCreditCardTypes();
        
        List<CartItems> _serviceList = new List<CartItems>();
        _services.ForEach(delegate (ServiceDTO s)
        {
            _serviceList.Add(new CartItems() { Service = s, Service_ID = s.Service_ID });
        });

        List<ServiceTypeDTO> _serviceTypesFiltered = _serviceTypes.Where(st => st.Service_Type_ID == 5).ToList();
        var _mList = new OrderMasterData
        {
            ServiceTypes = _serviceTypesFiltered,
            Services = _services,
            PaymentTypes = _data.GetPaymentTypes(),
            CreditCardTypes = _data.GetCreditCardTypes(),
            ServiceList = _serviceList
        };

        Context.Response.Write(js.Serialize(_mList));
        
    }
}