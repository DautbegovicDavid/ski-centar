using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface ILiftService : ICRUDService<Lift, LiftSearchObject, LiftInsertRequest, LiftInsertRequest>
    {

    }
}
