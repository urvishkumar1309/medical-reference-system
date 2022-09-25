using System;
using System.Configuration;
using System.Linq;
using MailKit.Net.Smtp;
using MimeKit;
using System.Web.Mvc;
using System.Web.Security;
using webapp.Helpers;
using webapp.Models;
using webapp.Models.ViewModels;

namespace webapp.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            AccountFunctions.EnsureLoggedOut();
            return View(new LoginVm());
        }

        [HttpPost]
        public ActionResult Index(LoginVm data)
        {
            try
            {
                using (var db = new DBEntities())
                {
                    if (data.Role.Equals("Doctor"))
                    {
                        var doctor = db.Doctors.FirstOrDefault(s => s.Aadhaar.Equals(data.Aadhaar) && s.Password.Equals(data.Password));

                        if (doctor != null)
                        {
                            if (doctor.IsActive)
                            {

                                SignInRemember(doctor.DoctorId.ToString(), true);

                                CookieHelper.Set(StaticValues.CookieDoctorName, doctor.Name);
                                CookieHelper.Set(StaticValues.CookieDoctorId, doctor.DoctorId.ToString());
                                CookieHelper.Set(StaticValues.CookieRole, data.Role);

                                Notification.Success = "Welcome " + doctor.Name;

                                return RedirectToAction("Index", "Dashboard");
                            }
                            else
                            {
                                Notification.Error = "Your account was suspended! Please, contact the administrator.";
                            }
                        }
                        else
                        {
                            Notification.Error = "Wrong credentials found!";
                        }
                    }
                    else
                    {
                        if (data.Aadhaar.Equals("111122223333") && data.Password.Equals("12345"))
                        {
                            SignInRemember("Admin", true);

                            CookieHelper.Set(StaticValues.CookieRole, data.Role);
                            CookieHelper.Set(StaticValues.CookieDoctorId, "0");
                            Notification.Success = "Welcome Admin";

                            return RedirectToAction("Index", "Dashboard");
                        }
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                Notification.Error = e.Message;
            }

            return RedirectToAction("Index");
        }

        public ActionResult Registration()
        {
            return View(new Doctor());
        }

        public JsonResult GetCities(long stateMasterId)
        {
            var data = CommonFunctions.DropDownGetCity(0, stateMasterId);

            return Json(new { data }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Registration(Doctor data)
        {
            try
            {
                using (var db = new DBEntities())
                {
                    var isExist = db.Doctors.FirstOrDefault(s => s.Aadhaar.Equals(data.Aadhaar));

                    if (isExist != null)
                    {
                        Notification.Error = "Doctor already exist with this aadhaar number!";
                    }
                    else
                    {
                        data.CreatedDate = DateTime.Now;
                        data.IsActive = true;
                        db.Doctors.Add(data);
                        db.SaveChanges();

                        Notification.Success = "You're successfully registered!";
                    }

                    return RedirectToAction("Index");
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        public ActionResult ForgotPassword()
        {
            return View(new LoginVm());
        }

        [HttpPost]
        public ActionResult ForgotPassword(LoginVm data)
        {
            try
            {
                using (var db = new DBEntities())
                {
                    var doctor =
                        db.Doctors.FirstOrDefault(s => s.Aadhaar.Equals(data.Aadhaar) && s.Email.Equals(data.Email, StringComparison.CurrentCultureIgnoreCase));

                    if (doctor != null)
                    {
                        var fromUser = ConfigurationManager.AppSettings["FromUser"];
                        var fromEmail = ConfigurationManager.AppSettings["FromEmail"];
                        var host = ConfigurationManager.AppSettings["Host"];
                        var port = Convert.ToInt32(ConfigurationManager.AppSettings["Port"]);
                        var ssl = Convert.ToBoolean(ConfigurationManager.AppSettings["SSL"]);
                        var mailGunUsername = ConfigurationManager.AppSettings["MailGunUsername"];
                        var mailGunPassword = ConfigurationManager.AppSettings["MailGunPassword"];

                        // Compose a message
                        var mail = new MimeMessage();
                        mail.From.Add(new MailboxAddress(fromUser, fromEmail));
                        mail.To.Add(new MailboxAddress(doctor.Name, doctor.Email));
                        mail.Subject = "You've requested us for password request!";
                        mail.Body = new TextPart("html")
                        {
                            Text = "<br/>  Your current password for Medical Reference is: &nbsp;<b> " + doctor.Password + " </b> " +
                                   "<br/> Thank You!"
                        };

                        // Send it!
                        using (var client = new SmtpClient())
                        {
                            // Should this be a little different?
                            client.ServerCertificateValidationCallback = (s, c, h, e) => true;

                            client.Connect(host, port, ssl);  //Our servers listen on ports 25, 587, and 465 (SSL/TLS)
                            client.AuthenticationMechanisms.Remove("XOAUTH2");
                            client.Authenticate(mailGunUsername, mailGunPassword);

                            client.Send(mail);
                            client.Disconnect(true);
                        }

                        Notification.Success = "We've send instruction in your mailbox!. Please review for same!";
                    }
                    else
                    {
                        Notification.Error = "Requested doctor not found in our system!";
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
            return View(new LoginVm());
        }

        private void SignInRemember(string userName, bool isPersistent = false)
        {
            // Clear any lingering authentication data
            FormsAuthentication.SignOut();

            // Write the authentication cookie
            FormsAuthentication.SetAuthCookie(userName, isPersistent);
        }

        public ActionResult Patient()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Patient(LoginVm data)
        {
            try
            {
                using (var db = new DBEntities())
                {
                    AccountFunctions.EnsureLoggedOut();

                    var patient = db.Patients.FirstOrDefault(s =>
                        s.Aadhaar.Equals(data.Aadhaar) && s.BirthDate.Equals(data.BirthDate));

                    if (patient != null)
                    {
                        return RedirectToAction("History", "Treatment", new { id = patient.PatientId, pid = 0 });
                    }
                    else
                    {
                        Notification.Error = "Patient details not found";
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                Notification.Error = e.Message;
            }

            return RedirectToAction("Patient");
        }


        public ActionResult About()
        {
            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }
    }
}