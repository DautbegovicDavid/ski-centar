using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface ITrailDifficultyService : ICRUDService<Model.TrailDifficulty, BaseSearchObject, TrailDifficultyUpsertRequest, TrailDifficultyUpsertRequest>
    {
    }
}
