using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TicketTypeSeniorityController : BaseController<Model.TicketTypeSeniority, TicketTypeSenioritySearchObject>
    {
        public TicketTypeSeniorityController(ITicketTypeSeniorityService service) : base(service) { }
    }
}
