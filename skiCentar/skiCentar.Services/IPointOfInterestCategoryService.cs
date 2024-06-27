using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface IPointOfInterestCategoryService : ICRUDService<Model.PointOfInterestCategory, BaseSearchObject, BaseNameRequest, BaseNameRequest>
    {
    }
}
