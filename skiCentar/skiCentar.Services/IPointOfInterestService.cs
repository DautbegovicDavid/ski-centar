using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface IPointOfInterestService : ICRUDService<Model.PointOfInterest, PointOfInterestSearchObject, PointOfInterestUpsertRequest, PointOfInterestUpsertRequest>
    {
    }
}
