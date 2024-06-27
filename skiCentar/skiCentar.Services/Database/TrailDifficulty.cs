using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class TrailDifficulty
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Color { get; set; } = null!;

    public virtual ICollection<Trail> Trails { get; set; } = new List<Trail>();
}
