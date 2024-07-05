using System;

namespace skiCentar.Model.Requests
{
    public class TicketUpsertRequest
    {

        public int TicketTypeId { get; set; }

        public decimal TotalPrice { get; set; }

        public string? Description { get; set; }

        public DateTime ValidFrom { get; set; }

        public DateTime ValidTo { get; set; }

        public bool? Active { get; set; }

    }
}
