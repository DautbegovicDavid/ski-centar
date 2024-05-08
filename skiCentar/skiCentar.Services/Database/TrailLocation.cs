using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class TrailLocation
{
    public int Id { get; set; }

    public int? TrailId { get; set; }

    public decimal? LocationX { get; set; }

    public decimal? LocationY { get; set; }

    public virtual Trail? Trail { get; set; }
}
