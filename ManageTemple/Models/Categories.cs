using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ManageTemple.Models
{
    public class ServiceType
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ServiceTypeID { get; set; }

        [DataType(DataType.Text)]
        [Required(ErrorMessage = "Name is a required field.")]
        [StringLength(maximumLength: 26, ErrorMessage = "Name must be between 2 to 26 characters.", MinimumLength = 2)]
        public string Name { get; set; }

        [DataType(DataType.Text)]
        [StringLength(maximumLength: 100, ErrorMessage = "Description must be 100 characters or less.", MinimumLength = 0)]
        public string Description { get; set; }

        //[DataType(DataType.Date)]
        //[Display(Name = "Effective Date")]
        //[DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}")]
        //[Required(ErrorMessage = "Effective Date is Required.")]
        //public DateTime EffectiveDate { get; set; }

        //[DataType(DataType.Date)]
        //[Display(Name = "Expiration Date")]
        //[DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}")]
        //public DateTime ExpirationDate { get; set; }

        [Display(Name = "Is Default?")]
        public bool isDefault { get; set; }

        [Display(Name = "Is Service?")]
        public bool isActive { get; set; }
        [Display(Name = "Supported Client Types")]
        public List<ClientType> ClientTypes { get; set; }

    }

    public class ClientType
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ClientTypeID { get; set; }

        [DataType(DataType.Text)]
        [Required(ErrorMessage = "Name is a required field.")]
        [StringLength(maximumLength: 26, ErrorMessage = "Name must be between {0} to {2} characters.", MinimumLength = 3)]
        public string Name { get; set; }

        [Display(Name = "Is Default?")]
        public bool isDefault { get; set; }

        [Display(Name = "Is Active?")]
        public bool isActive { get; set; }
        [Display(Name = "Service Types")]
        public virtual List<ServiceType> ServiceTypes { get; set; }

    }
}