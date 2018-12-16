using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommonDTO
{
    [Serializable]
    public class ClientDTO
    {
        public string ClientIP { get; set; }
        public string PrinterPort { get; set; }
        public string PrinterSettings { get; set; }
        public string ClientType { get; set; }


        public ClientDTO()
        {
            ClientIP = "";
            PrinterPort = "";
            PrinterSettings = "";
            ClientType = "";
        }
    }
}