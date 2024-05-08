namespace skiCentar.Model.Requests
{
    public class ResortInsertRequest
    {
        public string Name { get; set; } = null!;

        public string Location { get; set; } = null!;

        public int? Elevation { get; set; }

        public string SkiWorkHours { get; set; } = null!;
    }
}
