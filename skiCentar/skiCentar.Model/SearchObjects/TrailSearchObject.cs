namespace skiCentar.Model.SearchObjects
{
    public class TrailSearchObject : BaseSearchObject
    {
        public string? NameGTE { get; set; } = null!;

        public bool? IsDifficultyIncluded { get; set; }

        public bool? IsResortIncluded { get; set; }

        public bool? AreTrailLocationsIncluded { get; set; }

        public int? Length { get; set; }

        public bool? IsFunctional { get; set; }

        public int? ResortId { get; set; }

        public int? DifficultyId { get; set; }
    }
}
