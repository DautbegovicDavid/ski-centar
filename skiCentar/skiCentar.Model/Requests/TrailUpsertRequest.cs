using System.Collections.Generic;

namespace skiCentar.Model.Requests
{
    public class TrailUpsertRequest
    {
        public string Name { get; set; } = null!;

        public int? DifficultyId { get; set; }

        public decimal? Length { get; set; }

        public int? ResortId { get; set; }

        public bool? IsFunctional { get; set; }

        public List<TrailLocationUpsertRequest> TrailLocations { get; set; } = new List<TrailLocationUpsertRequest>();

    }
}
