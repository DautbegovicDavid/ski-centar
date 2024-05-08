namespace skiCentar.Model.SearchObjects
{
    public class LiftSearchObject : BaseSearchObject
    {
        public string? NameGTE { get; set; } = null!;
        public bool? isLiftTypeIncluded { get; set; }
        public bool? isResortIncluded { get; set; }
        public int? Capacity { get; set; }
        public bool? IsFunctional { get; set; }
    }
}
