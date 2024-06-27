using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    internal interface ILiftLocationService
    {
        List<LiftLocation> GetList(LiftSearchObject searchObject);
        Lift Insert(LiftUpsertRequest request);
        Lift Update(int id, LiftUpsertRequest request);
    }
}
