namespace skiCentar.Model
{
    public class TicketType
    {
        public int Id { get; set; }

        public int? TicketTypeSeniorityId { get; set; }

        public virtual TicketTypeSeniority? TicketTypeSeniority { get; set; }

        public bool FullDay { get; set; }

        public decimal Price { get; set; }
    }
}
