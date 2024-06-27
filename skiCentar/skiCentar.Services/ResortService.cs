using MapsterMapper;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;
using System.Linq.Dynamic.Core;

namespace skiCentar.Services
{
    public class ResortService : BaseCRUDService<Model.Resort, ResortSearchObject, Database.Resort, ResortInsertRequest, ResortInsertRequest>, IResortService
    {
        public ResortService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Database.Resort> AddFilter(ResortSearchObject searchObject, IQueryable<Database.Resort> query)
        {
            var filteredQuery = base.AddFilter(searchObject, query);
            if (!string.IsNullOrWhiteSpace(searchObject.NameGte))
            {
                filteredQuery = filteredQuery.Where(x => x.Name.StartsWith(searchObject.NameGte));
            }

            if (!string.IsNullOrWhiteSpace(searchObject.LocationGte))
            {
                filteredQuery = filteredQuery.Where(x => x.Location.StartsWith(searchObject.LocationGte));
            }

            if (searchObject.ElevationFrom > 0)
            {
                filteredQuery = filteredQuery.Where(x => x.Elevation >= searchObject.ElevationFrom);
            }

            if (searchObject.ElevationTo > 0)
            {
                filteredQuery = filteredQuery.Where(x => x.Elevation <= searchObject.ElevationTo);
            }

            //ovo je samo za npr za proizvode
            if (!string.IsNullOrEmpty(searchObject.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.Name.Contains(searchObject.FTS) || x.Location.Contains(searchObject.FTS));
            }
            return filteredQuery;

        }
    }
}
