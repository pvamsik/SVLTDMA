using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.Unity;
using System.Data;
using System.Web.Security;
using CommonDTO;


public interface IContainerAccessor
{
    IUnityContainer Container { get; }
}

public class Data
{
    Database db;
    public Database DB
    {
        get
        {
            return db;
        }
        set
        {
            db = value;
        }
    }
    public Data()
    {
        var accessor = HttpContext.Current.ApplicationInstance as IContainerAccessor;
        if (accessor == null)
        {
            return;
        }
        var container = accessor.Container;
        if (container == null)
        {
            throw new InvalidOperationException("No Unity container found");
        }

        lock (container)
        {
            db = container.Resolve<Database>();
        }
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
    public List<ClientDTO> GetClients()
    {

        IRowMapper<ClientDTO> rowMapper = MapBuilder<ClientDTO>.MapAllProperties()
                                        .Build();

        List<ClientDTO> s = new List<ClientDTO>();
        s = db.ExecuteSprocAccessor<ClientDTO>("dbo.clientSettings_Get", rowMapper).ToList<ClientDTO>();
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
    public List<PriestDTO> GetPriests()
    {

        IRowMapper<PriestDTO> rowMapper = MapBuilder<PriestDTO>.MapAllProperties()
                                        .Build();

        List<PriestDTO> p = new List<PriestDTO>();
        p = db.ExecuteSprocAccessor<PriestDTO>("dbo.GetPriests", rowMapper).ToList<PriestDTO>();
        return p;
    }
    public List<DevoteeDTO> GetAllDevotees()
    {

        IRowMapper<DevoteeDTO> rowMapper = MapBuilder<DevoteeDTO>.MapAllProperties()
                                        .Build();

        List<DevoteeDTO> p = new List<DevoteeDTO>();
        p = db.ExecuteSprocAccessor<DevoteeDTO>("dbo.GetAllDevotees", rowMapper).ToList<DevoteeDTO>();
        return p;
    }
    public int AddServiceRequest(ServiceRequestDTO devoteeServiceDTO)
    {
        string userName = "";
        userName = HttpContext.Current.User.Identity.Name;
        int Service_Request_ID = Convert.ToInt32(db.ExecuteScalar("dbo.ServiceRequest_Insert",
                                                                        new object[] { devoteeServiceDTO.Devotee_ID,
                                                                                            devoteeServiceDTO.Service_ID,
                                                                                            devoteeServiceDTO.Service_Date,
                                                                                            devoteeServiceDTO.Created_Date,
                                                                                            devoteeServiceDTO.Service_Fee_Paid,
                                                                                            devoteeServiceDTO.Payment_Type_id,
                                                                                            devoteeServiceDTO.Check_Number,
                                                                                            devoteeServiceDTO.Check_Date,
                                                                                            devoteeServiceDTO.Priest_Id,
                                                                                            userName,
                                                                                            "",
                                                                                            devoteeServiceDTO.Service_Request_ID,
                                                                                            devoteeServiceDTO.Comment1,
                                                                                            devoteeServiceDTO.Comment2,
                                                                                            devoteeServiceDTO.Comment3 }));
        return Service_Request_ID;
    }

    public List<ServiceRequestDTO> GetServiceRequests(int serviceRequestId, int devoteeId)
    {
        IRowMapper<ServiceRequestDTO> rowMapper = MapBuilder<ServiceRequestDTO>.MapAllProperties()
                                        .Build();
        List<ServiceRequestDTO> requests = new List<ServiceRequestDTO>();
        requests = db.ExecuteSprocAccessor<ServiceRequestDTO>("dbo.ServiceRequest_Select", rowMapper, new object[] { serviceRequestId, devoteeId }).ToList<ServiceRequestDTO>();
        if (requests.Any())
        {
            string requestIds = "";
            requestIds = string.Join(",", (from p in requests select p.Service_Request_ID).ToArray());
            List<ServiceRequestTransactionDTO> list = GetServiceRequestTransaction(0, requestIds);
            foreach (ServiceRequestDTO req in requests)
            {
                req.Transactions = list.FindAll(t => t.Service_Request_ID == req.Service_Request_ID);
            }
        }
        return requests;
    }
    public int VoidServiceRequest(int ServiceRequestId)
    {
        string userName = "";
        userName = HttpContext.Current.User.Identity.Name;
        int res = Convert.ToInt32(db.ExecuteScalar("dbo.ServiceRequest_Void", new object[] { ServiceRequestId, userName }));

        return res;
    }
    public void DeleteServiceRequest(int Service_Request_ID)
    {
        int reqId = Convert.ToInt32(db.ExecuteScalar("dbo.ServiceRequest_Delete", new object[] { Service_Request_ID, null }));
    }
    public int AddEditServiceRequestTransaction(int Service_Request_ID, int Service_Req_Tran_ID, string transactionType, paymentResponse paymentResponse, string ccType, string ccExpiration)
    {
        int c = Convert.ToInt32(db.ExecuteScalar("dbo.ServiceRequest_Transaction_Insert", new object[] { Service_Req_Tran_ID, Service_Request_ID, ccType, paymentResponse.TransactionID, transactionType, paymentResponse.CardNumber, ccExpiration, paymentResponse.RequestedAmount, paymentResponse.ApprovedAmount, paymentResponse.AuthCode, paymentResponse.AVSResponse, paymentResponse.CardCodeResponse, Convert.ToInt32(paymentResponse.Approved), paymentResponse.Message, paymentResponse.ResponseCode, null, null }));

        return c;
    }
    public List<ServiceRequestTransactionDTO> GetServiceRequestTransaction(int serviceReqTranID, string serviceRequestIDs)
    {

        IRowMapper<ServiceRequestTransactionDTO> rowMapper = MapBuilder<ServiceRequestTransactionDTO>.MapAllProperties()
                                        .Build();

        List<ServiceRequestTransactionDTO> p = new List<ServiceRequestTransactionDTO>();
        p = db.ExecuteSprocAccessor<ServiceRequestTransactionDTO>("dbo.ServiceRequest_Transaction_Select", rowMapper, new object[] { serviceReqTranID, serviceRequestIDs }).ToList<ServiceRequestTransactionDTO>();

        return p;
    }
    public DevoteeDTO GetDevotee(int devotee_ID)
    {

        IRowMapper<DevoteeDTO> rowMapper = MapBuilder<DevoteeDTO>.MapAllProperties()
                                        .Build();

        List<DevoteeDTO> p = new List<DevoteeDTO>();
        p = db.ExecuteSprocAccessor<DevoteeDTO>("dbo.Devotee_Select", rowMapper, new object[] { devotee_ID }).ToList<DevoteeDTO>();
        return p.FirstOrDefault();
    }
    public List<DevoteeDTO> GetDevotees(int devotee_ID, string phone, string firstName, string lastName)
    {

        IRowMapper<DevoteeDTO> rowMapper = MapBuilder<DevoteeDTO>.MapAllProperties()
                                        .Build();

        List<DevoteeDTO> p = new List<DevoteeDTO>();
        p = db.ExecuteSprocAccessor<DevoteeDTO>("dbo.Devotee_Select", rowMapper, new object[] { devotee_ID, phone, firstName, lastName }).ToList<DevoteeDTO>();
        return p;
    }
    public List<RolesDTO> GetRoles(string RoleName)
    {

        IRowMapper<RolesDTO> rowMapper = MapBuilder<RolesDTO>.MapAllProperties()
                                        .Build();

        List<RolesDTO> p = new List<RolesDTO>();
        p = db.ExecuteSprocAccessor<RolesDTO>("dbo.GetRoles", rowMapper, new object[] { RoleName }).ToList<RolesDTO>();
        return p;
    }
    public List<ManageableUsersDTO> GetManageableUsers(string RoleName)
    {

        IRowMapper<ManageableUsersDTO> rowMapper = MapBuilder<ManageableUsersDTO>.MapAllProperties()
                                        .Build();

        List<ManageableUsersDTO> p = new List<ManageableUsersDTO>();
        p = db.ExecuteSprocAccessor<ManageableUsersDTO>("dbo.GetManageableUsers", rowMapper, new object[] { RoleName }).ToList<ManageableUsersDTO>();
        return p;
    }
    public List<NameValueDTO> GetDevoteeFirstName(string Name)
    {

        IRowMapper<NameValueDTO> rowMapper = MapBuilder<NameValueDTO>.MapAllProperties()
                                        .Build();

        List<NameValueDTO> d = new List<NameValueDTO>();
        d = db.ExecuteSprocAccessor<NameValueDTO>("dbo.GetDevoteeFirstName", rowMapper, new object[] { Name }).ToList<NameValueDTO>();
        return d;
    }
    public List<NameValueDTO> GetDevoteeLastName(string Name)
    {

        IRowMapper<NameValueDTO> rowMapper = MapBuilder<NameValueDTO>.MapAllProperties()
                                        .Build();

        List<NameValueDTO> d = new List<NameValueDTO>();
        d = db.ExecuteSprocAccessor<NameValueDTO>("dbo.GetDevoteeLastName", rowMapper, new object[] { Name }).ToList<NameValueDTO>();
        return d;
    }
    public List<NameValueDTO> GetDevoteePhoneNumber(string Phone)
    {

        IRowMapper<NameValueDTO> rowMapper = MapBuilder<NameValueDTO>.MapAllProperties()
                                        .Build();

        List<NameValueDTO> d = new List<NameValueDTO>();
        d = db.ExecuteSprocAccessor<NameValueDTO>("dbo.GetDevoteePhoneNumber", rowMapper, new object[] { Phone }).ToList<NameValueDTO>();
        return d;
    }

}