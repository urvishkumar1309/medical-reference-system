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
    
    public partial class Prescription
    {
        public long PrescriptionId { get; set; }
        public long TreatmentId { get; set; }
        public string Medicine { get; set; }
        public int Quntity { get; set; }
        public int Morning { get; set; }
        public int Noon { get; set; }
        public int Evening { get; set; }
    
        public virtual Treatment Treatment { get; set; }
    }
}
