using MapsterMapper;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class BaseCRUDService<TModel, TSearch, TDbEntity, TInsert, TUpdate> : BaseService<TModel, TSearch, TDbEntity> where TModel : class where TSearch : BaseSearchObject where TDbEntity : class
    {
        public BaseCRUDService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public TModel Insert(TInsert request)
        {
            TDbEntity entity = Mapper.Map<TDbEntity>(request);

            BeforeInsert(request, entity);

            Context.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<TModel>(entity);
        }

        public void BeforeInsert(TInsert request, TDbEntity entity) { }

        public TModel Update(int id, TUpdate request)
        {
            var set = Context.Set<TDbEntity>();

            var entity = set.Find(id);

            Mapper.Map(request, entity);

            BeforeUpdate(request, entity);

            Context.SaveChanges();

            return Mapper.Map<TModel>(entity);
        }

        public void BeforeUpdate(TUpdate request, TDbEntity entity) { }

    }
}
