using MapsterMapper;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class UserRoleService : BaseCRUDService<Model.UserRole, BaseSearchObject, Database.UserRole, BaseNameRequest, BaseNameRequest>, IUserRoleService
    {
        public UserRoleService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
