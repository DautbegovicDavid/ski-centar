namespace skiCentar.Model.SearchObjects
{
    public class LiftSearchObject : BaseSearchObject
    {
        public string? NameGTE { get; set; } = null!;
        public bool? IsLiftTypeIncluded { get; set; }
        public bool? IsResortIncluded { get; set; }
        public bool? AreLiftLocationsIncluded { get; set; }
        public int? Capacity { get; set; }
        public bool? IsFunctional { get; set; }
        public int? ResortId { get; set; }
        public int? LiftTypeId { get; set; }

    }
}
