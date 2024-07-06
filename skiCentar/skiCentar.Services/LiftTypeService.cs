using MapsterMapper;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class LiftTypeService : BaseService<Model.LiftType, LiftTypeSearch, Database.LiftType>, ILiftTypeService
    {

        public LiftTypeService(SkiCenterContext context, IMapper mapper) : base(context, mapper) { }

        public override IQueryable<Database.LiftType> AddFilter(LiftTypeSearch search, IQueryable<Database.LiftType> query)
        {
            var filteredQuery = base.AddFilter(search, query);
            if (!string.IsNullOrWhiteSpace(search.NameGTE))
            {
                filteredQuery = filteredQuery.Where(x => x.Name.Contains(search.NameGTE));
            }
            return filteredQuery;
        }

    }
}
