namespace skiCentar.Model.Requests
{
    public class EmployeeUpsertRequest
    {
        public string Email { get; set; } = null!;

        public string Password { get; set; } = null!;

        public int UserRoleId { get; set; }

        public bool IsVerified { get; set; }
    }
}
