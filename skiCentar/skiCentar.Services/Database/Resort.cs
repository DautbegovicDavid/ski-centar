using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class Resort
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Location { get; set; } = null!;

    public int? Elevation { get; set; }

    public string SkiWorkHours { get; set; } = null!;

    public virtual ICollection<DailyWeather> DailyWeathers { get; } = new List<DailyWeather>();

    public virtual ICollection<Lift> Lifts { get; } = new List<Lift>();

    public virtual ICollection<PointOfInterest> PointOfInterests { get; } = new List<PointOfInterest>();

    public virtual ICollection<Trail> Trails { get; } = new List<Trail>();

    public virtual ICollection<User> Users { get; } = new List<User>();
}
