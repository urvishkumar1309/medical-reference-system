using System;
using System.Collections.Generic;

namespace webapp.Models.ViewModels
{
    public class TreatmentDetailsVm
    {
        public long TreatmentId { get; set; }
        public long DoctorId { get; set; }
        public long PatientId { get; set; }
        public string DoctorName { get; set; }
        public string HospitalName { get; set; }
        public string PatientName { get; set; }
        public string PatientAadhaar { get; set; }
        public string DiseaseName { get; set; }
        public string DiseaseReview { get; set; }
        public decimal DiseaseRating { get; set; }
        public string Advice { get; set; }
        public DateTime TreatmentDate { get; set; }
        public string AttachedFile { get; set; }
        public List<PrescriptionVm> PrescriptionVms { get; set; }
    }

    public class PrescriptionVm
    {
        public long PrescriptionId { get; set; } 
        public string Medicine { get; set; }
        public int Quntity { get; set; }
        public int Morning { get; set; }
        public int Noon { get; set; }
        public int Evening { get; set; }
    }

    public class TreatmentVm
    {
        public Patient Patient { get; set; }
        public bool IsShowModel { get; set; }
        public string MajorIssues { get; set; }
        public Doctor Doctor { get; set; }
        public Treatment Treatment { get; set; }
        public List<Prescription> Prescriptions { get; set; }
        public int Count { get; set; }
    }
}