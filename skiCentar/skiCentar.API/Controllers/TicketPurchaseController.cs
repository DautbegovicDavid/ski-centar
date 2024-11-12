using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
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
    public class TicketPurchaseController : BaseController<TicketPurchase, TicketPurchaseSearchObject>
    {
        public TicketPurchaseController(ITicketPurchaseService service) : base(service)
        {
        }
    }
}