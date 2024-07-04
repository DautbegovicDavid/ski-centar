namespace skiCentar.Model.SearchObjects
{
    public class PointOfInterestSearchObject : BaseSearchObject
    {

        public string? NameGTE { get; set; } = null!;

        public bool? IsCategoryIncluded { get; set; }

        public int? CategoryId { get; set; }

        public bool? IsResortIncluded { get; set; }

        public int? ResortId { get; set; }

    }
}
