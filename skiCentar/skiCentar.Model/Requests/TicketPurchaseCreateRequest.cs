using System;

namespace skiCentar.Model.Requests
{
    public class TicketPurchaseCreateRequest
    {
        public int UserId { get; set; }

        public int TicketId { get; set; }

        public DateTime? PurchaseDate { get; set; }

        public int Quantity { get; set; }

        public decimal TotalPrice { get; set; }

        public string? StripePaymentIntentId { get; set; }

        public int PaymentStatusId { get; set; }

    }
}
