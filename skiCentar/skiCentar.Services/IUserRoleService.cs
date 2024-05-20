using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface IUserRoleService : ICRUDService<Model.UserRole, BaseSearchObject, BaseNameRequest, BaseNameRequest>
    {
    }
}
