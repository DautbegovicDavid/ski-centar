using MapsterMapper;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class UserService : BaseCRUDService<Model.User, BaseSearchObject, Database.User, UserUpsertRequest, UserUpsertRequest>, IUserService
    {
        public UserService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public Model.User AddEmployee(EmployeeUpsertRequest request)
        {

            User entity = Mapper.Map<User>(request);

            entity.UserRoleId = request.UserRoleId;
            entity.Password = BCrypt.Net.BCrypt.HashPassword(request.Password);

            Context.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<Model.User>(entity);
        }

        public Model.User VerifyUser(int id)
        {
            var set = Context.Set<User>();

            var entity = set.Find(id);

            entity.IsVerified = true;

            Context.SaveChanges();

            return Mapper.Map<Model.User>(entity);

        }
    }
}
