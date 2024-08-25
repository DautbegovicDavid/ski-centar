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
    public class UserPoiController : BaseCRUDController<UserPoiInteraction, BaseSearchObject, UserPioInteractionUpsertRequest, UserPioInteractionUpsertRequest>
    {
        public UserPoiController(IUserPoiInteractionService service) : base(service) { }
    }
}
