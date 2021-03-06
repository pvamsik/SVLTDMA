﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

[Serializable]
public class DevoteeDTO
{
    public string Devotee_ID { get; set; }

    public string Devotee_Last_Name { get; set; }

    public string Devotee_First_Name { get; set; }
    
    public string Devotee_M_Name { get; set; }
    
    public string Devotee_Phone1 { get; set; }
    
    public string Devotee_Phone2 { get; set; }
    
    public string Devotee_Email1 { get; set; }
    
    public string Devotee_Email2 { get; set; }
    
    public string Devotee_Address1 { get; set; }
    
    public string Devotee_Address2 { get; set; }

    public string Devotee_City { get; set; }

    public string Devotee_State_CD { get; set; }

    public string Devotee_Zip_CD { get; set; }
       

}
[Serializable]
public class PaymentTypeDTO
{
    public int Payment_type_ID { get; set; }

    public string Payment_type_code { get; set; }

    public string Payment_type_description { get; set; }

    public bool ShowDefault { get; set; }
}
[Serializable]
public class CreditCardTypeDTO
{
    public int Credit_card_type_id { get; set; }

    public string Credit_card_type { get; set; }

    public string Credit_card_type_description { get; set; }

    public bool ShowDefault { get; set; }
}
[Serializable]
public class PriestDTO
{
    public int Priest_ID { get; set; }

    public string Priest_First_Name { get; set; }

    public string Priest_Last_Name { get; set; }

    public bool Priest_Active { get; set; }
}
[Serializable]
public class ServiceRequestDTO
{
    public int Service_Request_ID { get; set; }

    public int Devotee_ID { get; set; }

    public int Service_Type_ID { get; set; }

    public string Service_type_description { get; set; }

    public int Service_ID { get; set; }

    public string Service_Name { get; set; }

    public string Service_Date { get; set; }

    public string Created_Date { get; set; }

    public string Service_Fee_Paid { get; set; }

    public int Payment_Type_id { get; set; }

    public string Payment_type_description { get; set; }

    public string Check_Number { get; set; }

    public string Check_Date { get; set; }

    public int Priest_Id { get; set; }

    public string Priest_Name { get; set; }

    public string Status { get; set; }

    public string Comment1 { get; set; }

    public string Comment2 { get; set; }

    public string Comment3 { get; set; }

    public List<ServiceRequestTransactionDTO> Transactions { get; set; }

}
[Serializable]
public class ServiceRequestTransactionDTO
{
    public int Service_Req_Tran_ID { get; set; }

    public int Service_Request_ID { get; set; }

    public string TransactionID { get; set; }

    public string TransactionType { get; set; }

    public string CardType { get; set; }

    public string CardNumber { get; set; }

    public string CardExpiration { get; set; }

    public decimal RequestedAmount { get; set; }

    public decimal ApprovedAmount { get; set; }

    public string AuthCode { get; set; }

    public string AVSResponse { get; set; }

    public string CardCodeResponse { get; set; }

    public Boolean IsApproved { get; set; }

    public string TransactionMessage { get; set; }

    public string ResponseCode { get; set; }

    public string Created_Date { get; set; }
}
[Serializable]
public class RolesDTO
{
    public string RoleName { get; set; }

    public string Description { get; set; }
}
[Serializable]
public class ManageableUsersDTO
{
    public string UserName { get; set; }

    public string RoleName { get; set; }

    public string Email { get; set; }

    public Boolean IsApproved { get; set; }

    public Boolean IsLockedOut { get; set; }
}
[Serializable]
public class NameValueDTO
{
    public string Name { get; set; }
    public string Value { get; set; }
}
public class Utilities
{
    public static bool GetBoolean(object obj)
    {
        bool flag = false;

        if (!bool.TryParse(obj == null ? "0" : obj.ToString(), out flag))
            flag = false;

        return flag;
    }
    public static int GetInteger(object obj)
    {
        int number = 0;

        if (!int.TryParse(obj == null ? "0" : obj.ToString(), out number))
            number = 0;

        return number;
    }
}
