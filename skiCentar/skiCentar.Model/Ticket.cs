using System;

namespace skiCentar.Model
{
    public class Ticket
    {
        public int Id { get; set; }

        public int TicketTypeId { get; set; }

        public decimal TotalPrice { get; set; }

        public string? Description { get; set; }

        public DateTime ValidFrom { get; set; }

        public DateTime ValidTo { get; set; }

        public bool? Active { get; set; }

        public virtual TicketType TicketType { get; set; } = null!;
    }
}
