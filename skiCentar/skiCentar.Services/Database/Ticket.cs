using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class Ticket
{
    public int Id { get; set; }

    public int TicketTypeId { get; set; }

    public decimal TotalPrice { get; set; }

    public string? Description { get; set; }

    public DateTime ValidFrom { get; set; }

    public DateTime ValidTo { get; set; }

    public bool? Active { get; set; }

    public virtual ICollection<TicketPurchase> TicketPurchases { get; set; } = new List<TicketPurchase>();

    public virtual TicketType TicketType { get; set; } = null!;
}
