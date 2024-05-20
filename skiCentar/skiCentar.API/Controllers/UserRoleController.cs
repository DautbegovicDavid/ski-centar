using Microsoft.AspNetCore.Authorization;
using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Authorize(Roles = "Admin")]
    public class UserRoleController : BaseCRUDController<UserRole, BaseSearchObject, BaseNameRequest, BaseNameRequest>
    {
        public UserRoleController(IUserRoleService service) : base(service)
        {
        }
    }
}
