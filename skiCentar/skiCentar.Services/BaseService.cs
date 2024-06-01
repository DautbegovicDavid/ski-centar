using MapsterMapper;
using skiCentar.Model;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public abstract class BaseService<TModel, TSearch, TDbEntity> : IService<TModel, TSearch> where TSearch : BaseSearchObject where TDbEntity : class where TModel : class
    {
        public SkiCenterContext Context { get; set; }
        public IMapper Mapper { get; set; }

        public BaseService(SkiCenterContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public PagedResult<TModel> GetPaged(TSearch search)
        {
            List<TModel> result = new List<TModel>();

            var query = Context.Set<TDbEntity>().AsQueryable();

            query = AddFilter(search, query);

            int count = query.Count();

            if (search.Page.HasValue && search.PageSize.HasValue)
            {
                query = query.Skip(search.Page.Value * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = query.ToList();
            result = Mapper.Map(list, result);

            PagedResult<TModel> pagedResult = new PagedResult<TModel>();
            pagedResult.ResultList = result;
            pagedResult.Count = count;

            return pagedResult;
        }

        public virtual IQueryable<TDbEntity> AddFilter(TSearch searchObject, IQueryable<TDbEntity> query)
        {
            return query;
        }
        public virtual TModel GetById(int id)
        {
            var entity = Context.Set<TDbEntity>().Find(id);

            if (entity != null)
            {
                return Mapper.Map<TModel>(entity);
            }
            else
                return null;
        }
        //uvijek vracamo null da ne zbunimo FE clienta
    }
}
