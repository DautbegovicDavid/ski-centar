using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class UserService : BaseCRUDService<Model.User, BaseSearchObject, Database.User, UserUpsertRequest, UserUpsertRequest>, IUserService
    {
        ILogger<UserService> _logger;
        public UserService(SkiCenterContext context, IMapper mapper, ILogger<UserService> logger) : base(context, mapper)
        {
            _logger = logger;
        }

        public Model.User AddEmployee(EmployeeUpsertRequest request)
        {
            _logger.LogInformation($"Adding employee {request.Email}");

            User entity = Mapper.Map<User>(request);

            entity.UserRoleId = request.UserRoleId;
            entity.Password = BCrypt.Net.BCrypt.HashPassword(request.Password);

            Context.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<Model.User>(entity);
        }

        public override Model.User GetById(int id)
        {
            var entity = Context.Set<User>().Include(i => i.UserRole).Include(i => i.UserDetails).FirstOrDefault(f => f.Id == id);

            if (entity != null)
            {
                return Mapper.Map<Model.User>(entity);
            }
            else
                return null;
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
