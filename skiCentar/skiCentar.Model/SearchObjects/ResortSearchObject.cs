namespace skiCentar.Model.SearchObjects
{
    public class ResortSearchObject : BaseSearchObject
    {
        public string? NameGte { get; set; }
        public string? LocationGte { get; set; }
        public int? ElevationFrom { get; set; }
        public int? ElevationTo { get; set; }
        public string? FTS { get; set; }
    }
}
