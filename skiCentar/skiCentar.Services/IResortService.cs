using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface IResortService
    {
        PagedResult<Resort> GetList(ResortSearchObject searchObject);
        Resort Insert(ResortInsertRequest request);
        Resort Update(int id, ResortInsertRequest request);
    }
}
