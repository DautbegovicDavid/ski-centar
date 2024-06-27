using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class UserVerification
{
    public int Id { get; set; }

    public string VerificationCode { get; set; } = null!;

    public string Email { get; set; } = null!;

    public int UserId { get; set; }

    public virtual User User { get; set; } = null!;
}
