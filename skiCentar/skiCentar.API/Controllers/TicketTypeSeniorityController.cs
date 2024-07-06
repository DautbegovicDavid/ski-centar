using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class TicketTypeSeniorityController : BaseController<Model.TicketTypeSeniority, TicketTypeSenioritySearchObject>
    {
        public TicketTypeSeniorityController(ITicketTypeSeniorityService service) : base(service) { }
    }
}
