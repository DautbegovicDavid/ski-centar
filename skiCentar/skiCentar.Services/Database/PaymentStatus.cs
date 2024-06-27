using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class PaymentStatus
{
    public int Id { get; set; }

    public string Status { get; set; } = null!;

    public virtual ICollection<TicketPurchase> TicketPurchases { get; set; } = new List<TicketPurchase>();
}
