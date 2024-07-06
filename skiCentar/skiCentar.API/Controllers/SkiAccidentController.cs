using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SkiAccidentController : BaseCRUDController<SkiAccident, SkiAccidentSearchObject, SkiAccidentUpsertRequest, SkiAccidentUpsertRequest>
    {
        public SkiAccidentController(ISkiAccidentService service) : base(service)
        {
        }
    }
}
