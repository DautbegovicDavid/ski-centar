using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PointOfInterestCategoryController : BaseCRUDController<Model.PointOfInterestCategory, BaseSearchObject, BaseNameRequest, BaseNameRequest>
    {
        public PointOfInterestCategoryController(IPointOfInterestCategoryService service) : base(service)
        {
        }
    }
}
