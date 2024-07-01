namespace skiCentar.Model.SearchObjects
{
    public class TicketTypeSearchObject : BaseSearchObject
    {

        public bool? IsFullDay { get; set; }

        public decimal? PriceFrom { get; set; }

        public decimal? PriceTo { get; set; }

        public int? TicketTypeSeniorityId { get; set; }

    }
}
