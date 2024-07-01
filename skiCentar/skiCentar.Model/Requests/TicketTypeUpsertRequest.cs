namespace skiCentar.Model.Requests
{
    public class TicketTypeUpsertRequest
    {
        public bool FullDay { get; set; }

        public decimal Price { get; set; }

        public int TicketTypeSeniorityId { get; set; }
    }
}
