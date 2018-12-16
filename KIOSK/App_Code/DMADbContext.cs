using CommonDTO;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DMADbContext
/// </summary>
public class DMADbContext : DbContext
{
    public DMADbContext() : base("ApplicationServices")
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public System.Data.Entity.DbSet<Service_Type> serviceTypes { get; set; }
}