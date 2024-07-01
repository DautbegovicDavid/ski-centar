using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    public class TicketTypeController : BaseCRUDController<TicketType, TicketTypeSearchObject, TicketTypeUpsertRequest, TicketTypeUpsertRequest>
    {
        public TicketTypeController(ITicketTypeService service) : base(service) { }
    }
}
