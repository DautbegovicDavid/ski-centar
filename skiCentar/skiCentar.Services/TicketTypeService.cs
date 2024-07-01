using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class TicketTypeService : BaseCRUDService<Model.TicketType, TicketTypeSearchObject, TicketType, TicketTypeUpsertRequest, TicketTypeUpsertRequest>, ITicketTypeService
    {
        public TicketTypeService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<TicketType> AddFilter(TicketTypeSearchObject searchObject, IQueryable<TicketType> query)
        {
            var filteredQuery = base.AddFilter(searchObject, query);

            if (searchObject.PriceFrom > 0)
            {
                filteredQuery = filteredQuery.Where(x => x.Price >= searchObject.PriceFrom);
            }

            if (searchObject.PriceTo > 0)
            {
                filteredQuery = filteredQuery.Where(x => x.Price <= searchObject.PriceTo);
            }

            if (searchObject.IsFullDay.HasValue)
            {
                if (searchObject.IsFullDay.Value)
                {
                    filteredQuery = filteredQuery.Where(x => x.FullDay == true);
                }
                else
                {
                    filteredQuery = filteredQuery.Where(x => x.FullDay == false);
                }
            }
            if (searchObject.TicketTypeSeniorityId.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.TicketTypeSeniorityId == searchObject.TicketTypeSeniorityId);
            }

            filteredQuery = filteredQuery.Include(x => x.TicketTypeSeniority);

            return filteredQuery;
        }
    }
}
