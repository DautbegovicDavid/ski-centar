using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class LiftType
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Lift> Lifts { get; set; } = new List<Lift>();
}
