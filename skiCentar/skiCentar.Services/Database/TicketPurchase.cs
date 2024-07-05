namespace skiCentar.Services.Database;

public partial class TicketPurchase
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int TicketId { get; set; }

    public DateTime? PurchaseDate { get; set; }

    public int Quantity { get; set; }

    public decimal TotalPrice { get; set; }

    public string? StripePaymentIntentId { get; set; }

    public virtual Ticket Ticket { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
