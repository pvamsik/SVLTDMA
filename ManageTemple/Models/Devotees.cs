using System;
using System.ComponentModel.DataAnnotations;

namespace ManageTemple.Models
{
    [Serializable]
    public class Devotees
    {
        [Key]
        public int ID { get; set; }

        [Display( Name = "Title" )]
        public string Title { get; set; }

        [Display(Name = "First Name")]
        [Required(ErrorMessage = "First Name is Required")]
        [MinLength(2, ErrorMessage = "Please enter first name at least 2 characters long. ")]
        [MaxLength(25, ErrorMessage = "Please enter first name less than 25 characters long. ")]
        public string FirstName { get; set; }

        [Display(Name = "Middle Name")]
        [MinLength(2, ErrorMessage = "Please enter Middle name 2 characters long or less.")]
        [MaxLength(2, ErrorMessage = "Please enter Middle name 2 characters long or less.")]
        public string MiddleName { get; set; }

        [Display(Name = "Last Name")]
        [Required(ErrorMessage = "Last Name is Required")]
        [MinLength(2, ErrorMessage = "Please enter last name at least 2 characters long. ")]
        [MaxLength(25, ErrorMessage = "Please enter last name less than 25 characters long. ")]
        public string LastName { get; set; }

        [Required]
        [MaxLength(250, ErrorMessage = "Address must be 250 Characters or less." )]
        public string Address { get; set; }

        [Required]
        [MaxLength(250, ErrorMessage = "Address must be 250 Characters or less.")]
        public string City { get; set; }

        [Required]
        [MaxLength(10, ErrorMessage = "Address must be 10 Characters or less.")]
        public string State { get; set; }

        [Required]
        [Display(Name = "Zip Code" )]
        [DataType(DataType.PostalCode, ErrorMessage ="Please enter a valid Postal Code")]
        public string Zip { get; set; }

        [Required(ErrorMessage = "Primary Phone Number is Required")]
        [Display(Name = "Primary Phone")]
        [DataType(DataType.PhoneNumber, ErrorMessage = "Please enter a valid Phone Number")]
        public string PhoneNumber1 { get; set; }

        [Display(Name = "Secondary Phone")]
        [DataType(DataType.PhoneNumber, ErrorMessage = "Please enter a valid Phone Number")]
        public string PhoneNumber2 { get; set; }

        [Required(ErrorMessage = "Primary Email Address is Required")]
        [Display(Name = "Primary Email Address")]
        [DataType(DataType.EmailAddress, ErrorMessage = "Please enter a Valid Email Address")]
        public string Email1 { get; set; }

        [Display(Name = "Secondary Email Address")]
        [DataType(DataType.EmailAddress, ErrorMessage = "Please enter a Valid Email Address")]
        public string Email2 { get; set; }
    }
}