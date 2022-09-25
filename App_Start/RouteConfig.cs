using System.Web.Mvc;
using System.Web.Routing;

namespace webapp
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}/{pid}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional, pid = UrlParameter.Optional }
            );
        }
    }
}
