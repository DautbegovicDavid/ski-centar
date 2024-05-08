using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class LiftMaintenance
{
    public int Id { get; set; }

    public DateTime? MaintenanceStart { get; set; }

    public DateTime? MaintenanceEnd { get; set; }

    public string? Description { get; set; }

    public int? LiftId { get; set; }

    public virtual Lift? Lift { get; set; }
}
