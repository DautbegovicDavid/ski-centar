namespace skiCentar.Services.Database;

public partial class Resort
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string Location { get; set; } = null!;

    public int? Elevation { get; set; }

    public string SkiWorkHours { get; set; } = null!;

    public virtual ICollection<DailyWeather> DailyWeathers { get; set; } = new List<DailyWeather>();

    public virtual ICollection<Lift> Lifts { get; set; } = new List<Lift>();

    public virtual ICollection<PointOfInterest> PointOfInterests { get; set; } = new List<PointOfInterest>();

    public virtual ICollection<Trail> Trails { get; set; } = new List<Trail>();

    public virtual ICollection<User> Users { get; set; } = new List<User>();

    public virtual ICollection<TicketType> TicketTypes { get; set; } = new List<TicketType>();

}
