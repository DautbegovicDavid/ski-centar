using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LiftController : ControllerBase
    {
        protected ILiftService _service;

        public LiftController(ILiftService service)
        {
            _service = service;
        }

        [HttpGet]
        public PagedResult<Lift> GetList([FromQuery] LiftSearchObject searchObject)
        {
            return _service.GetList(searchObject);
        }
        [HttpPost]
        public Lift Insert(LiftInsertRequest request)
        {
            return _service.Insert(request);
        }

        [HttpPut("{id}")]
        public Lift Update(int id, LiftInsertRequest request)
        {
            return _service.Update(id, request);
        }
    }
}
