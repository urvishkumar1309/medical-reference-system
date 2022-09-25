using System;

namespace webapp.Models.ViewModels
{
    public class LoginVm
    {
        public string Aadhaar { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Role { get; set; }
        public DateTime BirthDate { get; set; }
    }

    public class Response
    {
        public bool Success { get; set; }
        public string Message { get; set; }
    }

    public class DashboardVm
    {
        public int Doctor { get; set; }
        public int Patient { get; set; }
        public int Treatment { get; set; }
        public bool IsAdmin { get; set; }
    }
}