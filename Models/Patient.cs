//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace webapp.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Patient
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Patient()
        {
            this.Treatments = new HashSet<Treatment>();
        }
    
        public long PatientId { get; set; }
        public long StateMasterId { get; set; }
        public long CityMasterId { get; set; }
        public string Aadhaar { get; set; }
        public System.DateTime BirthDate { get; set; }
        public string Mobile { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Gender { get; set; }
        public string BloodGroup { get; set; }
        public string Address { get; set; }
        public string Pincode { get; set; }
        public System.DateTime CreatedDate { get; set; }
        public string Profile { get; set; }
        public bool IsActive { get; set; }
    
        public virtual CityMaster CityMaster { get; set; }
        public virtual StateMaster StateMaster { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Treatment> Treatments { get; set; }
    }
}
