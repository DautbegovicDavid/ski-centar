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

    public bool? IsVerified { get; set; }

    public virtual ICollection<SkiAccident> SkiAccidents { get; set; } = new List<SkiAccident>();

    public virtual ICollection<TicketPurchase> TicketPurchases { get; set; } = new List<TicketPurchase>();

    public virtual UserDetail? UserDetails { get; set; }

    public virtual UserRole? UserRole { get; set; }

    public virtual ICollection<UserVerification> UserVerifications { get; set; } = new List<UserVerification>();

    public virtual ICollection<Resort> Resorts { get; set; } = new List<Resort>();
}
