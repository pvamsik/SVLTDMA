using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using CommonDTO;

public class CartItems
{
    [Key]
    public string ItemId { get; set; }
    public string CartId { get; set; }
    public string dateCreated { get; set; }
    public string orderDate { get; set; }
    public int Service_ID { get; set; }
    public int Quantity { get; set; }
    public string comment { get; set; }
    public virtual ServiceDTO Service { get; set; }

}