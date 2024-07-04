namespace skiCentar.Services.Database;

public partial class TicketType
{
    public int Id { get; set; }

    public bool FullDay { get; set; }

    public decimal Price { get; set; }

    public int? TicketTypeSeniorityId { get; set; }

    public virtual TicketTypeSeniority? TicketTypeSeniority { get; set; }

    public int? ResortId { get; set; }

    public virtual Resort? Resort { get; set; }

    public virtual ICollection<Ticket> Tickets { get; set; } = new List<Ticket>();
}
