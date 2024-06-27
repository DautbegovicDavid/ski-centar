using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TrailDifficultyController : BaseCRUDController<TrailDifficulty, BaseSearchObject, TrailDifficultyUpsertRequest, TrailDifficultyUpsertRequest>
    {
        public TrailDifficultyController(ITrailDifficultyService service) : base(service)
        {
        }
    }
}
