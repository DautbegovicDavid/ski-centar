using skiCentar.Model;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    // kazemo da je search object minimalno basesearch object pa da imamo paginaciju
    public interface IService<TModel, TSearch> where TSearch : BaseSearchObject
    {
        public PagedResult<TModel> GetPaged(TSearch search);
        public TModel GetById(int id);
    }
}
