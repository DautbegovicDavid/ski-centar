using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class Lift
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int? LiftTypeId { get; set; }

    public int? Capacity { get; set; }

    public int? ResortId { get; set; }

    public bool? IsFunctional { get; set; }

    public string? StateMachine { get; set; }

    public virtual ICollection<LiftLocation> LiftLocations { get; set; } = new List<LiftLocation>();

    public virtual ICollection<LiftMaintenance> LiftMaintenances { get; set; } = new List<LiftMaintenance>();

    public virtual LiftType? LiftType { get; set; }

    public virtual Resort? Resort { get; set; }
}
