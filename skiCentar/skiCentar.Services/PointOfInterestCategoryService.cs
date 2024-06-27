using MapsterMapper;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class PointOfInterestCategoryService : BaseCRUDService<Model.PointOfInterestCategory, BaseSearchObject, PoiCategory, BaseNameRequest, BaseNameRequest>, IPointOfInterestCategoryService
    {
        public PointOfInterestCategoryService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
