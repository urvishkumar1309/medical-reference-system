using System.Web;
using System.Web.Mvc;

namespace webapp.Helpers
{
    public class CheckAuthorization : AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            if (string.IsNullOrWhiteSpace(CookieHelper.Get(StaticValues.CookieDoctorId)) || !HttpContext.Current.Request.IsAuthenticated)
            {
                if (filterContext.HttpContext.Request.IsAjaxRequest())
                {
                    filterContext.HttpContext.Response.StatusCode = 302; //Found Redirection to another page. Here- login page. Check Layout ajaxError() script.
                    filterContext.HttpContext.Response.End();
                }
                else
                {
                    filterContext.Result = new RedirectResult(System.Web.Security.FormsAuthentication.LoginUrl + "?ReturnUrl=" +
                                                              filterContext.HttpContext.Server.UrlEncode(filterContext.HttpContext.Request.RawUrl));
                }
            }
            else
            { 
                //Code HERE for page level authorization 
            }
        }
    }
}