using System;

namespace skiCentar.Model.SearchObjects
{
    public class UserSearchObject : BaseSearchObject
    {
        public string? emailGte { get; set; }
        public bool isUserRoleIncluded { get; set; }
        public bool areUserDetailsIncluded { get; set; }
        public int userRoleId { get; set; }
        public bool isVerified { get; set; }
        public DateTime dateRegisteredFrom { get; set; }
        public DateTime dateRegisteredTo { get; set; }

    }
}
