using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using webapp.Helpers;
using webapp.Models;
using webapp.Models.ViewModels;

namespace webapp.Controllers
{

    public class TreatmentController : Controller
    {
        [CheckAuthorization]
        public ActionResult Index(long id = 0, long pid = 0)
        {
            //id === Patient Id || pid == Treatment Id
            try
            {
                using (var db = new DBEntities())
                {
                    var model = new TreatmentVm
                    {
                        Patient = new Patient(),
                        IsShowModel = true,
                        Doctor = new Doctor(),
                        Prescriptions = new List<Prescription>(),
                        Treatment = new Treatment(),
                        Count = 1
                    };

                    var currentDoctor = AccountFunctions.GetCurrentDoctorId();

                    if (currentDoctor > 0)
                    {
                        model.Doctor = db.Doctors.Find(currentDoctor);
                    }

                    if (id > 0)
                    {
                        model.Patient = db.Patients.Find(id);
                        model.IsShowModel = false;

                        var majorDiseases = db.Treatments.Where(s => s.PatientId.Equals(id) && s.DiseaseRating >= 7).ToList();

                        model.MajorIssues = majorDiseases.Any() ? string.Join(",", majorDiseases.Select(s => s.DiseaseName).ToList()) : "N/A";

                        model.Treatment.PatientId = id;
                    }

                    if (pid > 0)
                    {
                        //Edit Operation HERE
                        model.Treatment = db.Treatments.Find(pid);

                        model.Prescriptions = db.Prescriptions.Where(s => s.TreatmentId == model.Treatment.TreatmentId)
                            .ToList();

                        if (model.Prescriptions.Any())
                            model.Count = model.Prescriptions.Count;
                    }

                    return View(model);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }

        }

        [CheckAuthorization]
        [HttpPost]
        public ActionResult AddPatient([Bind(Prefix = "Patient")]Patient data)
        {
            try
            {
                using (var db = new DBEntities())
                {
                    long id = 0;

                    data.CreatedDate = DateTime.Now;
                    data.IsActive = true;
                    db.Patients.Add(data);
                    db.SaveChanges();

                    id = data.PatientId;

                    Notification.Success = "Patient registered successfully";

                    return RedirectToAction("Index", "Treatment", new { id = id });
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        [CheckAuthorization]
        [HttpPost]
        public ActionResult AddTreatment([Bind(Prefix = "Treatment")]Treatment data, List<Prescription> prescriptions, HttpPostedFileBase attachment)
        {

            var response = CommonFunctions.AddEditTreatment(data, prescriptions, attachment);

            if (response.Success)
            {
                Notification.Success = response.Message;
            }
            else
            {
                Notification.Error = response.Message;
            }

            return RedirectToAction("Index", "Treatment", new { id = data.PatientId });
        }

        [CheckAuthorization]
        public JsonResult IsPatientExists(string aadhaar)
        {
            try
            {
                using (var db = new DBEntities())
                {
                    var data = db.Patients.FirstOrDefault(s => s.Aadhaar.Equals(aadhaar));

                    if (data != null)
                        return Json(new { status = true, data.PatientId }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }

            return Json(new { status = false }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult History(long id = 0, long pid = 0)
        {
            //id === Patient Id
            //pid === Doctor Id

            var doctorId = AccountFunctions.GetCurrentDoctorId();

            if (pid > 0)
                doctorId = pid;

            var data = CommonFunctions.GetTreatmentDetails(doctorId, id, AccountFunctions.GetCurrentRole().Equals("Admin"));

            return View(data);
        }

        [CheckAuthorization]
        public ActionResult Delete(long id)
        {
            try
            {
                using (var db = new DBEntities())
                {
                    var treatment = db.Treatments.Find(id);

                    if (treatment != null)
                    {
                        var prescription = db.Prescriptions.Where(s => s.TreatmentId == id).ToList();

                        if (prescription.Any())
                        {
                            db.Prescriptions.RemoveRange(prescription);
                            db.SaveChanges();
                        }

                        db.Treatments.Remove(treatment);
                        db.SaveChanges();

                        Notification.Success = "Treatment deleted successfully!";
                    }
                    else
                    {
                        Notification.Error = "Treatment not found";
                    }

                    return RedirectToAction("History", "Treatment", new { id = 0, pid = 0 });
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }
    }
}