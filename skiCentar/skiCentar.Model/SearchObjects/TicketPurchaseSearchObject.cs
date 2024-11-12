using System;
using System.Collections.Generic;
using System.Text;

namespace skiCentar.Model.SearchObjects
{
    public class TicketPurchaseSearchObject : BaseSearchObject
    {
        public int? UserId { get; set; }

        public int? TicketTypeId { get; set; }

        public bool? IsTicketTypeIncluded { get; set; }

        public decimal? TotalPriceFrom { get; set; }

        public decimal? TotalPriceTo { get; set; }

        public DateTime? PurchaseDateFrom { get; set; }

        public DateTime? PurchaseDateTo { get; set; }
    }
}