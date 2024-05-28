using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : BaseCRUDController<Model.User, BaseSearchObject, UserUpsertRequest, UserUpsertRequest>
    {
        public UserController(IUserService service) : base(service)
        {
        }
        [HttpPut("verify/{id}")]
        public Model.User Verify(int id)
        {
            return (_service as IUserService).VerifyUser(id);
        }

        [HttpPost("employee")]
        public Model.User Employee([FromBody] EmployeeUpsertRequest request)
        {
            return (_service as IUserService).AddEmployee(request);
        }
    }
}
