using AuthorizeNet;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administration_ccTransactionList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //open a call to the Gateway
        var gate = new ReportingGateway(ConfigurationManager.AppSettings["AuthorizeNetCPLogin"].ToString(), 
                                        ConfigurationManager.AppSettings["AuthorizeNetCPTransactionKey"].ToString());

        //Get all the batches settled
        var batches = gate.GetSettledBatchList(new DateTime(2014, 5, 1), new DateTime(2014, 5, 14));

        Console.WriteLine("All Batches in the last 30 days");

        //Loop each batch returned
        foreach (var item in batches) {
            Console.WriteLine("Batch ID: {0}, Settled On : {1}", item.ID,
                              item.SettledOn.ToShortDateString());
        }

        Console.WriteLine("*****************************************************");
        Console.WriteLine();

        //get all Transactions for the last 30 days
        var transactions = gate.GetTransactionList();
        foreach (var item in transactions)
        {
            ccTransactions.InnerHtml = "Transaction " + item.TransactionID + ": Card: " + item.CardNumber + " for " + item.SettleAmount.ToString("C") + " on " + item.DateSubmitted.ToShortDateString();
        }
    }
}