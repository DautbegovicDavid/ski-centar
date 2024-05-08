using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface ILiftService
    {
        PagedResult<Lift> GetList(LiftSearchObject searchObject);
        Lift Insert(LiftInsertRequest request);
        Lift Update(int id, LiftInsertRequest request);
    }
}
