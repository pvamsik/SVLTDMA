using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Security;
using CommonDTO;
using System.Data.Common;
using AutoMapper;
using Microsoft.Practices.EnterpriseLibrary.Data;

public class Data
{
    Database db;
    public Data()
    {
        DatabaseProviderFactory factory = new DatabaseProviderFactory();
        db = factory.Create("ApplicationServices");
    }
    public List<ServiceTypeDTO> GetServiceTypes()
    {
        IRowMapper<ServiceTypeDTO> rowMapper = MapBuilder<ServiceTypeDTO>.MapAllProperties()
                                        .Build();
        List<ServiceTypeDTO> s = new List<ServiceTypeDTO>();
        s = db.ExecuteSprocAccessor<ServiceTypeDTO>("dbo.GetServiceTypes", rowMapper).ToList<ServiceTypeDTO>();
        return s;
    }
    public List<ServiceDTO> GetServices()
    {
        IRowMapper<ServiceDTO> rowMapper = MapBuilder<ServiceDTO>.MapAllProperties()
                                        .Build();
        List<ServiceDTO> s = new List<ServiceDTO>();
        s = db.ExecuteSprocAccessor<ServiceDTO>("dbo.GetServices", rowMapper).ToList<ServiceDTO>();
        return s;
    }
    public List<PaymentTypeDTO> GetPaymentTypes()
    {
        IRowMapper<PaymentTypeDTO> rowMapper = MapBuilder<PaymentTypeDTO>.MapAllProperties()
                                        .Build();
        List<PaymentTypeDTO> p = new List<PaymentTypeDTO>();
        p = db.ExecuteSprocAccessor<PaymentTypeDTO>("dbo.GetPaymentTypes", rowMapper).ToList<PaymentTypeDTO>();
        return p;
    }
    public List<CreditCardTypeDTO> GetCreditCardTypes()
    {
        IRowMapper<CreditCardTypeDTO> rowMapper = MapBuilder<CreditCardTypeDTO>.MapAllProperties()
                                        .Build();
        List<CreditCardTypeDTO> p = new List<CreditCardTypeDTO>();
        p = db.ExecuteSprocAccessor<CreditCardTypeDTO>("dbo.GetCreditCardTypes", rowMapper).ToList<CreditCardTypeDTO>();
        return p;
    }
}