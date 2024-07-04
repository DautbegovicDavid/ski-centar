using MapsterMapper;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class UserDetailService : BaseCRUDService<Model.UserDetail, BaseSearchObject, UserDetail, UserDetailUpsertRequest, UserDetailUpsertRequest>, IUserDetailService
    {
        public UserDetailService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override Model.UserDetail Insert(UserDetailUpsertRequest request)
        {
            var set = Context.Set<UserDetail>();
            var entity = Mapper.Map<UserDetail>(request);
            set.Add(entity);
            Context.SaveChanges();

            var userSet = Context.Set<User>();
            var user = userSet.Find(request.UserId);
            if (user != null)
            {
                user.UserDetailsId = entity.Id;
                Context.SaveChanges();
            }
            return Mapper.Map<Model.UserDetail>(entity);

        }
    }
}
