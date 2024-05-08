namespace skiCentar.Model
{
    public class Resort
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public string Location { get; set; } = null!;

        public int? Elevation { get; set; }

        public string SkiWorkHours { get; set; } = null!;

    }
}
