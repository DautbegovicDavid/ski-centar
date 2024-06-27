using System.Collections.Generic;

namespace skiCentar.Model.Requests
{
    public class LiftUpsertRequest
    {
        public string Name { get; set; } = null!;

        public int? LiftTypeId { get; set; }

        public int? Capacity { get; set; }

        public int? ResortId { get; set; }

        public bool? IsFunctional { get; set; }

        public List<LiftLocationUpsertRequest> LiftLocations { get; set; } = new List<LiftLocationUpsertRequest>();
    }
}
