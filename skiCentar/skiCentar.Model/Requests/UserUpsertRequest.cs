namespace skiCentar.Model.Requests
{
    public class UserUpsertRequest
    {

        public string Email { get; set; } = null!;

        public int? UserRoleId { get; set; }

        public bool? IsVerified { get; set; }

    }
}
