using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface ILiftService : ICRUDService<Lift, LiftSearchObject, LiftUpsertRequest, LiftUpsertRequest>
    {
        public Lift Activate(int id);
        public Lift Edit(int id);
        public Lift Hide(int id);
        public List<string> AllowedActions(int id);

    }
}
