using System;
using System.IO;
using System.Web;

namespace webapp.Helpers
{
    public static class Utilities
    {
        public static string SaveFile(HttpPostedFileBase file, string physicalPath)
        {
            try
            {
                //Check directory exis or not
                if (!Directory.Exists(physicalPath)) Directory.CreateDirectory(physicalPath);

                //Save new image and update user data
                var filename = string.Concat(Guid.NewGuid(), Path.GetExtension(file.FileName));
                var savePath = Path.Combine(physicalPath, filename);
                file.SaveAs(savePath);

                return filename;
            }
            catch (Exception e)
            {
                return string.Empty;
            }
        }
    }
}