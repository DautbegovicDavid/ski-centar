using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface ISkiAccidentService : ICRUDService<Model.SkiAccident, SkiAccidentSearchObject, SkiAccidentUpsertRequest, SkiAccidentUpsertRequest>
    {
    }
}
