using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class PointOfInterestService : BaseCRUDService<Model.PointOfInterest, PointOfInterestSearchObject, PointOfInterest, PointOfInterestUpsertRequest, PointOfInterestUpsertRequest>, IPointOfInterestService
    {
        public PointOfInterestService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<PointOfInterest> AddFilter(PointOfInterestSearchObject searchObject, IQueryable<PointOfInterest> query)
        {
            query = base.AddFilter(searchObject, query);
            if (!string.IsNullOrWhiteSpace(searchObject.NameGTE))
            {
                query = query.Where(x => x.Name.StartsWith(searchObject.NameGTE));
            }
            if (searchObject.isCategoryIncluded == true)
            {
                query = query.Include(x => x.Category);
            }

            if (searchObject.isResortIncluded == true)
            {
                query = query.Include(x => x.Resort);
            }


            if (searchObject.resortId > 0)
            {
                query = query.Where(x => x.ResortId == searchObject.resortId);
            }
            if (searchObject.categoryId > 0)
            {
                query = query.Where(x => x.CategoryId == searchObject.categoryId);
            }


            return query;
        }
    }
}
