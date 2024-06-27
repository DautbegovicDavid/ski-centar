using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface ITrailService : ICRUDService<Model.Trail, TrailSearchObject, TrailUpsertRequest, TrailUpsertRequest>
    {
    }
}
