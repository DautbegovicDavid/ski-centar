using System;

namespace skiCentar.Model
{
    public class User
    {
        public int Id { get; set; }

        public string Email { get; set; } = null!;

        public DateTime? RegistrationDate { get; set; }

        public DateTime? LastLoginDate { get; set; }

        public int? UserRoleId { get; set; }

        public int? UserDetailsId { get; set; }

        public bool? IsVerified { get; set; }

        public virtual UserDetail? UserDetails { get; set; }

        public virtual UserRole? UserRole { get; set; }

    }
}
