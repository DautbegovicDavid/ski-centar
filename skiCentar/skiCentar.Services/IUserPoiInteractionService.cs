using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface IUserPoiInteractionService : ICRUDService<Model.UserPoiInteraction, BaseSearchObject, UserPioInteractionUpsertRequest, UserPioInteractionUpsertRequest>
    {
    }
}
