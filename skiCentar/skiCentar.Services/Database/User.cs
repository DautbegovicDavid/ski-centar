using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class User
{
    public int Id { get; set; }

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public DateTime? RegistrationDate { get; set; }

    public DateTime? LastLoginDate { get; set; }

    public int? UserRoleId { get; set; }

    public int? UserDetailsId { get; set; }

    public virtual ICollection<SkiAccident> SkiAccidents { get; } = new List<SkiAccident>();

    public virtual UserDetail? UserDetails { get; set; }

    public virtual UserRole? UserRole { get; set; }

    public virtual ICollection<Resort> Resorts { get; } = new List<Resort>();
}
