using System;
using System.Collections.Generic;

namespace skiCentar.Services.Database;

public partial class TicketTypeSeniority
{
    public int Id { get; set; }

    public string Seniority { get; set; } = null!;

    public virtual ICollection<TicketType> TicketTypes { get; set; } = new List<TicketType>();
}
