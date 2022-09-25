namespace webapp.Helpers
{
    
    public static class SuccessMessage
    {
        public const string Created = "Record created successfully!";
        public const string Updated = "Record updated successfully!";
        public const string Activated = "Record activated successfully!";
        public const string Deactivated = "Record deactivated successfully!";
        public const string Deleted = "Record removed successfully!";
        public const string PasswordUpdated = "Password updated successfully!";
    }

    public static class ErrorMessage
    {
        public const string SessionExpired = "Session expired! Please login again!";
        public const string SomethingWentWrong = "Something went wrong! Please try after some time!";
        public const string DataNotAvailable = "Data not available!";
        public const string Unauthorized = "Unauthorized request found!";
    }

    public static class Notification
    {
        public static string Success { get; set; }
        public static string Error { get; set; }
    }
}