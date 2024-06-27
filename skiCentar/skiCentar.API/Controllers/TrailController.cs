using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]

    public class TrailController : BaseCRUDController<Trail, TrailSearchObject, TrailUpsertRequest, TrailUpsertRequest>
    {
        public TrailController(ITrailService service) : base(service)
        {
        }
    }
}
