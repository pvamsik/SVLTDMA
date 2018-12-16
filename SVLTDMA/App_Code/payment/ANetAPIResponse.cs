using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AuthorizeNet.Api.Controllers;
using AuthorizeNet.Api.Contracts.V1;
using AuthorizeNet.Api.Controllers.Bases;
using CommonDTO;

/// <summary>
/// Summary description for ANetAPIResponse
/// </summary>
public class ANetResponse
{
    public ANetApiResponse response { get; set; }
    public transactionResponse transResponse { get; set; }
    public ANetResponse()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}