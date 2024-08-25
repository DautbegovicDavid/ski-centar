using MapsterMapper;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class UserPoiInteractionService : BaseCRUDService<Model.UserPoiInteraction, BaseSearchObject, UserPoiInteraction, UserPioInteractionUpsertRequest, UserPioInteractionUpsertRequest>, IUserPoiInteractionService
    {
        public UserPoiInteractionService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
