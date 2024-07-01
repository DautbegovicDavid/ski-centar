using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class UserService : BaseCRUDService<Model.User, UserSearchObject, User, UserUpsertRequest, UserUpsertRequest>, IUserService
    {
        ILogger<UserService> _logger;
        public UserService(SkiCenterContext context, IMapper mapper, ILogger<UserService> logger) : base(context, mapper)
        {
            _logger = logger;
        }
        public override IQueryable<User> AddFilter(UserSearchObject searchObject, IQueryable<User> query)
        {
            var filteredQuery = base.AddFilter(searchObject, query);
            if (searchObject.areUserDetailsIncluded)
            {
                filteredQuery = filteredQuery.Include(x => x.UserDetails);
            }

            if (searchObject.isUserRoleIncluded)
            {
                filteredQuery = filteredQuery.Include(x => x.UserRole);
            }

            if (searchObject.userRoleId > 0)
            {
                filteredQuery = filteredQuery.Where(x => x.UserRoleId == searchObject.userRoleId);
            }

            if (!string.IsNullOrWhiteSpace(searchObject.emailGte))
            {
                filteredQuery = filteredQuery.Where(x => x.Email.StartsWith(searchObject.emailGte));
            }

            if (searchObject.dateRegisteredFrom != DateTime.MinValue)
            {
                filteredQuery = filteredQuery.Where(x => x.RegistrationDate >= searchObject.dateRegisteredFrom);
            }

            if (searchObject.dateRegisteredTo != DateTime.MinValue)
            {
                var toDate = searchObject.dateRegisteredTo.Date.AddDays(1).AddTicks(-1);
                filteredQuery = filteredQuery.Where(x => x.RegistrationDate <= toDate);
            }


            return filteredQuery;
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
