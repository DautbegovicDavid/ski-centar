using System;

namespace skiCentar.Model.SearchObjects
{
    public class SkiAccidentSearchObject : BaseSearchObject
    {
        public int? UserId { get; set; }

        public int? TrailId { get; set; }

        public int? PeopleInvolvedFrom { get; set; }

        public int? PeopleInvolvedTo { get; set; }

        public DateTime? DateFrom { get; set; }

        public DateTime? DateTo { get; set; }

        public bool? IsActive { get; set; }
    }
}
