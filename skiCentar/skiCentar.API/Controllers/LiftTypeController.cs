using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]

    public class LiftTypeController : BaseController<Model.LiftType, LiftTypeSearch>
    {
        public LiftTypeController(ILiftTypeService service) : base(service) { }
    }
}
