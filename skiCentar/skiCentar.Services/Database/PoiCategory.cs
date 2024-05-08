using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class PoiCategory
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<PointOfInterest> PointOfInterests { get; } = new List<PointOfInterest>();
}
