using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommonDTO
{
    [Serializable]
    public class OrderMasterData
    {
        public List<ServiceTypeDTO> ServiceTypes { get; set; }
        public List<ServiceDTO> Services { get; set; }
        public List<PaymentTypeDTO> PaymentTypes { get; set; }
        public List<CreditCardTypeDTO> CreditCardTypes { get; set; }
        public List<CartItems> ServiceList { get; set; }
    }
}
