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
    public class ResortController : BaseCRUDController<Resort, ResortSearchObject, ResortInsertRequest, ResortInsertRequest>
    {

        public ResortController(IResortService service) : base(service)
        {
        }
    }
}
