using System;
using System.Linq;
using System.Web.Mvc;
using webapp.Helpers;
using webapp.Models;
using webapp.Models.ViewModels;

namespace webapp.Controllers
{
    public class DashboardController : Controller
    {

        public ActionResult Index()
        {
            try
            {
                using (var db = new DBEntities())
                {
                    var model = new DashboardVm();

                    var patients = db.Patients.ToList();
                    var doctors = db.Doctors.ToList();
                    var treatments = db.Treatments.ToList();

                    var role = AccountFunctions.GetCurrentRole();
                    var doctorId = AccountFunctions.GetCurrentDoctorId();

                    if (role.Equals("Admin"))
                    {
                        model.IsAdmin = true;
                        model.Patient = patients.Count;
                        model.Doctor = doctors.Count;
                        model.Treatment = treatments.Count;
                    }
                    else
                    {
                        model.IsAdmin = false;
                        model.Patient = treatments.Where(s => s.DoctorId == doctorId).Select(s => s.PatientId).GroupBy(s => s).Count();
                        model.Treatment = treatments.Count(s => s.DoctorId == doctorId);
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

        public ActionResult Sample()
        {
            return View();
        }
    }
}