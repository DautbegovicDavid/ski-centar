namespace skiCentar.Model.Requests
{
    public class LiftInsertRequest
    {
        public string Name { get; set; } = null!;

        public int? LiftTypeId { get; set; }

        public int? Capacity { get; set; }

        public int? ResortId { get; set; }

        public bool? IsFunctional { get; set; }
    }
}
