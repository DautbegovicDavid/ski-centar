using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class TicketService : BaseCRUDService<Model.Ticket, TicketSearchObject, Ticket, TicketUpsertRequest, TicketUpsertRequest>, ITicketService
    {
        public TicketService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Ticket> AddFilter(TicketSearchObject searchObject, IQueryable<Ticket> query)
        {
            var filteredQuery = base.AddFilter(searchObject, query);

            if (searchObject.TotalPriceFrom > 0)
            {
                filteredQuery = filteredQuery.Where(x => x.TotalPrice >= searchObject.TotalPriceFrom);
            }

            if (searchObject.TotalPriceTo > 0)
            {
                filteredQuery = filteredQuery.Where(x => x.TotalPrice <= searchObject.TotalPriceTo);
            }

            if (searchObject.TicketTypeId.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.TicketTypeId == searchObject.TicketTypeId);
            }

            if (searchObject.ValidFrom != DateTime.MinValue && searchObject.ValidFrom.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.ValidFrom >= searchObject.ValidFrom);
            }

            if (searchObject.ValidTo != DateTime.MinValue && searchObject.ValidTo.HasValue)
            {
                var toDate = searchObject.ValidTo.Value.AddDays(1).AddTicks(-1);
                filteredQuery = filteredQuery.Where(x => x.ValidTo <= toDate);
            }

            if (searchObject.Active.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.Active == searchObject.Active);
            }

            if (searchObject.IsTicketTypeIncluded.HasValue && searchObject.IsTicketTypeIncluded == true)
            {
                filteredQuery = filteredQuery.Include(x => x.TicketType);
            }

            return filteredQuery;
        }
    }
}
