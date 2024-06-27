using MapsterMapper;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class TrailDifficultyService : BaseCRUDService<Model.TrailDifficulty, BaseSearchObject, Database.TrailDifficulty, TrailDifficultyUpsertRequest, TrailDifficultyUpsertRequest>, ITrailDifficultyService
    {
        public TrailDifficultyService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
