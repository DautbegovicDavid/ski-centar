using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class TrailMaintenance
{
    public int Id { get; set; }

    public DateTime? MaintenanceStart { get; set; }

    public DateTime? MaintenanceEnd { get; set; }

    public string? Description { get; set; }

    public int? TrailId { get; set; }

    public virtual Trail? Trail { get; set; }
}
