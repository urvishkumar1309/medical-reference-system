using System;
using System.Security.Principal;
using System.Web;
using System.Web.Security;

namespace webapp.Helpers
{
    public static class AccountFunctions
    {
        public static void EnsureLoggedOut()
        {
            // First we clean the authentication ticket like always
            //required NameSpace: using System.Web.Security;
            FormsAuthentication.SignOut();

            // Second we clear the principal to ensure the user does not retain any authentication
            //required NameSpace: using System.Security.Principal;
            HttpContext.Current.User = new GenericPrincipal(new GenericIdentity(string.Empty), null);

            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.RemoveAll();

            CookieHelper.Delete(StaticValues.CookieDoctorId);
            CookieHelper.Delete(StaticValues.CookieDoctorName);
            CookieHelper.Delete(StaticValues.CookieRole); 
        }

        public static long GetCurrentDoctorId()
        {
            var x = CookieHelper.Get(StaticValues.CookieDoctorId);
            return !string.IsNullOrWhiteSpace(x) ? Convert.ToInt64(x) : 0;
        }

        public static string GetCurrentRole()
        {
            return CookieHelper.Get(StaticValues.CookieRole);
        }
    }
}