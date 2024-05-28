using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface IUserService : ICRUDService<Model.User, BaseSearchObject, UserUpsertRequest, UserUpsertRequest>
    {
        Model.User VerifyUser(int id);
        Model.User AddEmployee(EmployeeUpsertRequest request);
    }
}
