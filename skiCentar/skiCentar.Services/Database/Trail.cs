using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class Trail
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int? DifficultyId { get; set; }

    public decimal? Length { get; set; }

    public int? ResortId { get; set; }

    public bool? IsFunctional { get; set; }

    public virtual TrailDifficulty? Difficulty { get; set; }

    public virtual Resort? Resort { get; set; }

    public virtual ICollection<SkiAccident> SkiAccidents { get; set; } = new List<SkiAccident>();

    public virtual ICollection<TrailLocation> TrailLocations { get; set; } = new List<TrailLocation>();

    public virtual ICollection<TrailMaintenance> TrailMaintenances { get; set; } = new List<TrailMaintenance>();
}
