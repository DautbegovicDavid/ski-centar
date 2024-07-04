using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface IUserDetailService : ICRUDService<Model.UserDetail, BaseSearchObject, UserDetailUpsertRequest, UserDetailUpsertRequest>
    {
    }
}
