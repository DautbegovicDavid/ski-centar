namespace skiCentar.Model.SearchObjects
{
    public class PointOfInterestSearchObject : BaseSearchObject
    {

        public string? NameGTE { get; set; } = null!;

        public bool? isCategoryIncluded { get; set; }

        public int? categoryId { get; set; }

        public bool? isResortIncluded { get; set; }

        public int? resortId { get; set; }

    }
}
