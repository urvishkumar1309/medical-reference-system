using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using webapp.Helpers;
using webapp.Models;

namespace webapp.Controllers
{
    public class UsersController : Controller
    {
        public ActionResult Doctors()
        {
            try
            {
                using (var db = new DBEntities())
                {
                    var data = db.Doctors.ToList();
                    return View(data);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        public ActionResult BlockUnblockDoctor(long id)
        {

            try
            {
                using (var db = new DBEntities())
                {
                    var user = db.Doctors.Find(id);

                    if (user != null)
                    {
                        user.IsActive = !user.IsActive;
                        db.Entry(user).State = EntityState.Modified;
                        db.SaveChanges();

                        Notification.Success = user.IsActive ? "Doctor activated successfully." : "Doctor de-activated successfully.";
                    }
                    else
                    {
                        Notification.Error = "Doctor not available.";
                    }

                    return RedirectToAction("Doctors");
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        public ActionResult Patients()
        {
            try
            {
                using (var db = new DBEntities())
                {
                    var data = db.Patients.ToList();
                    return View(data);
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