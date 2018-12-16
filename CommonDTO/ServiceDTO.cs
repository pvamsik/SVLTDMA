using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Linq;
using System.Text;

namespace CommonDTO
{
    [Serializable]
    public class ServiceDTO
    {
        public int Service_ID { get; set; }
        public string ServiceDescription { get; set; }
        public int Service_Type_ID { get; set; }
        public decimal Service_Fee { get; set; }
        public string Service_Name { get; set; }
        public bool ShowDefault { get; set; }
        public bool PriceEditable { get; set; }
        public bool IsActive { get; set; }
    }

}
