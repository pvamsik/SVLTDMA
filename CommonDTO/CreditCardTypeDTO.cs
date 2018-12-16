using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommonDTO
{
    [Serializable]
    public class CreditCardTypeDTO
    {
        public int Credit_card_type_id { get; set; }
        public string Credit_card_type { get; set; }
        public string Credit_card_type_description { get; set; }
        public bool ShowDefault { get; set; }
    }
}
