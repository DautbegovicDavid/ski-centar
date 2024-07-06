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
    public class TicketController : BaseCRUDController<Ticket, TicketSearchObject, TicketUpsertRequest, TicketUpsertRequest>
    {
        public TicketController(ITicketService service) : base(service)
        {
        }
    }
}
