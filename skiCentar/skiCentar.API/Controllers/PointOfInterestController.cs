using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    //[Authorize]
    public class PointOfInterestController : BaseCRUDController<Model.PointOfInterest, PointOfInterestSearchObject, PointOfInterestUpsertRequest, PointOfInterestUpsertRequest>
    {
        public PointOfInterestController(IPointOfInterestService service) : base(service)
        {
        }
    }
}
