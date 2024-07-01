using MapsterMapper;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class TicketTypeSeniorityService : BaseService<Model.TicketTypeSeniority, TicketTypeSenioritySearchObject, TicketTypeSeniority>, ITicketTypeSeniorityService
    {
        public TicketTypeSeniorityService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<TicketTypeSeniority> AddFilter(TicketTypeSenioritySearchObject searchObject, IQueryable<TicketTypeSeniority> query)
        {
            var filteredQuery = base.AddFilter(searchObject, query);
            if (!string.IsNullOrWhiteSpace(searchObject.NameGTE))
            {
                filteredQuery = filteredQuery.Where(x => x.Seniority.Contains(searchObject.NameGTE));
            }
            return filteredQuery;
        }
    }
}
