using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommonDTO
{
    [Serializable]
    public class PaymentTypeDTO
    {
        public int Payment_type_ID { get; set; }

        public string Payment_type_code { get; set; }

        public string Payment_type_description { get; set; }

        public bool ShowDefault { get; set; }
    }
}
