using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class LiftLocation
{
    public int Id { get; set; }

    public int? LiftId { get; set; }

    public decimal? LocationX { get; set; }

    public decimal? LocationY { get; set; }

    public virtual Lift? Lift { get; set; }
}
