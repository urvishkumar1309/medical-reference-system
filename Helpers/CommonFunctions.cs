using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using webapp.Models;
using webapp.Models.ViewModels;

namespace webapp.Helpers
{
    public static class CommonFunctions
    {
        public static List<TreatmentDetailsVm> GetTreatmentDetails(long doctorId, long patientId, bool isAdmin)
        {
            List<TreatmentDetailsVm> response;

            try
            {
                using (var db = new DBEntities())
                {
                    response = db.Treatments.Select(s => new TreatmentDetailsVm
                    {
                        DiseaseRating = s.DiseaseRating,
                        Advice = s.Advice,
                        DiseaseReview = s.DiseaseReview,
                        AttachedFile = s.AttachedFile,
                        TreatmentId = s.TreatmentId,
                        HospitalName = s.Doctor.HospitalName,
                        DiseaseName = s.DiseaseName,
                        DoctorName = s.Doctor.Name,
                        PatientAadhaar = s.Patient.Aadhaar,
                        PatientName = s.Patient.FirstName,
                        TreatmentDate = s.CreatedDate,
                        DoctorId = s.DoctorId,
                        PatientId = s.PatientId,
                        PrescriptionVms = s.Prescriptions.Select(k => new PrescriptionVm
                        {
                            Medicine = k.Medicine,
                            Quntity = k.Quntity,
                            Noon = k.Noon,
                            Morning = k.Morning,
                            PrescriptionId = k.PrescriptionId,
                            Evening = k.Evening
                        }).ToList()
                    }).ToList();

                    if (doctorId > 0)
                    {
                        response = response.Where(s => s.DoctorId.Equals(doctorId)).ToList();
                    }
                    else if (patientId > 0)
                    {
                        response = response.Where(s => s.PatientId.Equals(patientId)).ToList();
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }

            return response;
        }

        public static Response AddEditTreatment(Treatment data, List<Prescription> prescriptions, HttpPostedFileBase attachment)
        {
            var response = new Response
            {
                Success = false
            };

            var path = HttpContext.Current.Server.MapPath("~/Files/Treatment");

            try
            {
                using (var db = new DBEntities())
                {
                    if (data.TreatmentId > 0)
                    {
                        //Edit Operation HERE

                        var existingData = db.Treatments.Find(data.TreatmentId);

                        if (existingData != null)
                        {
                            if (attachment != null)
                            {
                                existingData.AttachedFile = Utilities.SaveFile(attachment, path);
                            }

                            if (AccountFunctions.GetCurrentRole().Equals("Admin"))
                                existingData.DoctorId = data.DoctorId;

                            existingData.Advice = data.Advice;
                            existingData.DiseaseName = data.DiseaseName;
                            existingData.DiseaseRating = data.DiseaseRating;
                            existingData.DiseaseReview = data.DiseaseReview;
                            existingData.CreatedDate = data.CreatedDate;
                            existingData.UpdatedDate = DateTime.Now;
                            db.Entry(existingData).State = EntityState.Modified;
                            db.SaveChanges();

                            var existingPrescriptions =
                                db.Prescriptions.Where(s => s.TreatmentId == data.TreatmentId).ToList();

                            if (existingPrescriptions.Any())
                            {
                                db.Prescriptions.RemoveRange(existingPrescriptions);
                                db.SaveChanges();
                            }

                            if (prescriptions != null && prescriptions.Any())
                            {
                                var addPrescriptions = prescriptions.Select(s => new Prescription
                                {
                                    TreatmentId = existingData.TreatmentId,
                                    Medicine = s.Medicine,
                                    Evening = s.Evening,
                                    Morning = s.Morning,
                                    Noon = s.Noon,
                                    Quntity = s.Quntity
                                }).ToList();

                                db.Prescriptions.AddRange(addPrescriptions);
                                db.SaveChanges();
                            }
                            response.Success = true;
                            response.Message = "Treatment updated successfully!";
                        }
                        else
                        {
                            response.Message = "Treatment data not found!";
                        }
                    }
                    else
                    {
                        //Add Operation HERE
                        if (attachment != null)
                        {
                            data.AttachedFile = Utilities.SaveFile(attachment, path);
                        }

                        if (AccountFunctions.GetCurrentRole().Equals("Doctor"))
                            data.DoctorId = AccountFunctions.GetCurrentDoctorId();

                        db.Treatments.Add(data);
                        db.SaveChanges();

                        if (prescriptions != null && prescriptions.Any())
                        {
                            var addPrescriptions = prescriptions.Select(s => new Prescription
                            {
                                TreatmentId = data.TreatmentId,
                                Medicine = s.Medicine,
                                Evening = s.Evening,
                                Morning = s.Morning,
                                Noon = s.Noon,
                                Quntity = s.Quntity
                            }).ToList();

                            db.Prescriptions.AddRange(addPrescriptions);
                            db.SaveChanges();
                        }

                        response.Success = true;
                        response.Message = "Treatment added successfully!";
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                response.Message = e.Message;
            }

            return response;
        }

        public static List<SelectListItem> DropDownGetDoctor(long selectedId)
        {
            var response = new List<SelectListItem> { new SelectListItem { Text = "Select Doctor", Value = string.Empty } };
            try
            {
                using (var db = new DBEntities())
                {
                    var cats = db.Doctors.ToList();

                    if (cats.Any())
                    {
                        response.AddRange(cats.Select(s => new SelectListItem
                        {
                            Value = s.DoctorId.ToString(),
                            Text = s.Name,
                            Selected = s.DoctorId == selectedId
                        }).ToList());
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);

            }

            return response;
        }

        public static List<SelectListItem> DropDownGetState(long selectedId)
        {
            var response = new List<SelectListItem> { new SelectListItem { Text = "Select State", Value = string.Empty } };
            try
            {
                using (var db = new DBEntities())
                {
                    var cats = db.StateMasters.ToList();

                    if (cats.Any())
                    {
                        response.AddRange(cats.Select(s => new SelectListItem
                        {
                            Value = s.StateMasterId.ToString(),
                            Text = s.Name,
                            Selected = s.StateMasterId == selectedId
                        }).ToList());
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);

            }

            return response;
        }

        public static List<SelectListItem> DropDownGetCity(long selectedId, long stateMasterId)
        {
            var response = new List<SelectListItem> { new SelectListItem { Text = "Select City", Value = string.Empty } };
            try
            {
                using (var db = new DBEntities())
                {
                    var cats = db.CityMasters.Where(s => s.StateMasterId.Equals(stateMasterId)).ToList();

                    if (cats.Any())
                    {
                        response.AddRange(cats.Select(s => new SelectListItem
                        {
                            Value = s.CityMasterId.ToString(),
                            Text = s.Name,
                            Selected = s.StateMasterId == selectedId
                        }).ToList());
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);

            }

            return response;
        }
    }
}