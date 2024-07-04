using System;

namespace skiCentar.Model.Requests
{
    public class UserDetailUpsertRequest
    {
        public int UserId { get; set; }

        public string? Name { get; set; }

        public string? LastName { get; set; }

        public DateTime? DateOfBirth { get; set; }
    }
}
