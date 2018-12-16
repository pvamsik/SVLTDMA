using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CommonDTO;

/// <summary>
/// Summary description for BaseControl
/// </summary>
public class BaseControl : System.Web.UI.UserControl
{

    //public BasePage Basepage;
    public Data data;

    //public List<ServiceTypeDTO> ServiceTypes;

    //public List<ServiceDTO> Services;

    //public List<PaymentTypeDTO> PaymentTypes;

    //public List<CreditCardTypeDTO> CreditCardTypes;

    //public List<PriestDTO> Priests;

    public BaseControl()
    {
        //
        // TODO: Add constructor logic here
        //
        BasePage basepage = new BasePage();
        data = basepage.data;
        //ServiceTypes = basepage.ServiceTypes;
        //Services = basepage.Services;
        //PaymentTypes = basepage.PaymentTypes;
        //CreditCardTypes = basepage.CreditCardTypes;
        //Priests = basepage.Priests;
    }

    protected List<ServiceTypeDTO> ServiceTypes
    {
        get
        {
            if (ViewState["ServiceTypes"] == null)
                ViewState["ServiceTypes"] = data.GetServiceTypes().FindAll(s => s.IsActive == true);

            return (List<ServiceTypeDTO>)ViewState["ServiceTypes"];

        }
    }
    protected List<ServiceDTO> Services
    {
        get
        {
            if (ViewState["Services"] == null)
                ViewState["Services"] = data.GetServices();

            return (List<ServiceDTO>)ViewState["Services"];

        }
    }
}