using System;

namespace skiCentar.Model.SearchObjects
{
    public class TicketSearchObject : BaseSearchObject
    {
        public int? TicketTypeId { get; set; }

        public bool? IsTicketTypeIncluded { get; set; }

        public decimal? TotalPriceFrom { get; set; }

        public decimal? TotalPriceTo { get; set; }

        public DateTime? ValidFrom { get; set; }

        public DateTime? ValidTo { get; set; }

        public bool? Active { get; set; }

    }
}
