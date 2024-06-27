using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface IUserService : ICRUDService<Model.User, UserSearchObject, UserUpsertRequest, UserUpsertRequest>
    {
        Model.User VerifyUser(int id);

        Model.User AddEmployee(EmployeeUpsertRequest request);
    }
}
