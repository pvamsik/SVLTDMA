using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;

namespace CommonDTO
{
    [Serializable]
    public class ServiceTypeDTO
    {
        [Key]
        public int Service_Type_ID { get; set; }
        public string Service_type { get; set; }
        public string Service_type_description { get; set; }
        public bool ShowDefault { get; set; }
        public bool IsActive { get; set; }
    }
}