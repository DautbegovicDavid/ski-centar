using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class UserService : BaseCRUDService<Model.User, UserSearchObject, Database.User, UserUpsertRequest, UserUpsertRequest>, IUserService
    {
        ILogger<UserService> _logger;
        public UserService(SkiCenterContext context, IMapper mapper, ILogger<UserService> logger) : base(context, mapper)
        {
            _logger = logger;
        }
        public override IQueryable<Database.User> AddFilter(UserSearchObject searchObject, IQueryable<Database.User> query)
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

            Database.User entity = Mapper.Map<Database.User>(request);

            entity.UserRoleId = request.UserRoleId;
            entity.Password = BCrypt.Net.BCrypt.HashPassword(request.Password);

            Context.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<Model.User>(entity);
        }

        public override Model.User GetById(int id)
        {
            var entity = Context.Set<Database.User>().Include(i => i.UserRole).Include(i => i.UserDetails).FirstOrDefault(f => f.Id == id);

            if (entity != null)
            {
                var response = Mapper.Map<Model.User>(entity);
                response.HasActiveTicket = HasActiveTicket(id);
                return response;
            }
            else
                return null;
        }
        public bool HasActiveTicket(int id)
        {
            var today = DateTime.Today;

            var hasActiveTicket = Context.TicketPurchases.Where(w => w.UserId == id).Include(i => i.Ticket).Any(
                ticket =>
                ticket.Ticket.Active == true &&
                ticket.Ticket.ValidFrom <= today &&
                ticket.Ticket.ValidTo >= today);

            return hasActiveTicket;
        }

        public Model.User VerifyUser(int id)
        {
            var set = Context.Set<Database.User>();

            var entity = set.Find(id);

            entity.IsVerified = true;

            Context.SaveChanges();

            return Mapper.Map<Model.User>(entity);

        }
    }
}
