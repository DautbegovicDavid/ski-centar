using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LiftController : BaseCRUDController<Lift, LiftSearchObject, LiftUpsertRequest, LiftUpsertRequest>
    {
        public LiftController(ILiftService service) : base(service)
        {
        }
        [HttpPut("{id}/activate")]
        public Model.Lift Activate(int id)
        {
            return (_service as ILiftService).Activate(id);
        }
        [HttpPut("{id}/edit")]
        public Model.Lift Edit(int id)
        {
            return (_service as ILiftService).Edit(id);
        }
        [HttpPut("{id}/hide")]
        public Model.Lift Hide(int id)
        {
            return (_service as ILiftService).Hide(id);
        }
        [HttpGet("{id}/allowedActions")]
        public List<string> AllowedActions(int id)
        {
            return (_service as ILiftService).AllowedActions(id);
        }
    }
}
