namespace skiCentar.Model.SearchObjects
{
    public class TrailSearchObject : BaseSearchObject
    {
        public string? NameGTE { get; set; } = null!;

        public bool? isDifficultyIncluded { get; set; }

        public bool? isResortIncluded { get; set; }

        public bool? areTrailLocationsIncluded { get; set; }

        public int? Length { get; set; }

        public bool? IsFunctional { get; set; }

        public int? resortId { get; set; }

        public int? DifficultyId { get; set; }
    }
}
