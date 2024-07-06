using System;

namespace skiCentar.Model
{
    public class SkiAccident
    {
        public int Id { get; set; }

        public int? UserId { get; set; }

        public int? TrailId { get; set; }

        public int? PeopleInvolved { get; set; }

        public bool? IsReporterInjured { get; set; }

        public bool? IsActive { get; set; }

        public decimal? LocationX { get; set; }

        public decimal? LocationY { get; set; }

        public DateTime? Timestamp { get; set; }

        public string Description { get; set; } = null!;

        public virtual Trail? Trail { get; set; }

        public virtual User? User { get; set; }
    }
}
