using MapsterMapper;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class LiftTypeService : BaseService<Model.LiftType, LiftTypeSearch, Database.LiftType>, ILiftTypeService
    {


        public LiftTypeService(SkiCenterContext context, IMapper mapper) : base(context, mapper) { }

        public override IQueryable<Database.LiftType> AddFilter(LiftTypeSearch search, IQueryable<Database.LiftType> query)
        {
            var filteredQuery = base.AddFilter(search, query);
            if (!string.IsNullOrWhiteSpace(search.NameGTE))
            {
                filteredQuery = filteredQuery.Where(x => x.Name.Contains(search.NameGTE));
            }
            return filteredQuery;
        }

        //public virtual List<Model.LiftType> GetList(ResortSearchObject searchObject)
        //{
        //    List<Model.LiftType> result = new List<Model.LiftType>();

        //    var query = Context.LiftTypes.AsQueryable();

        //    //if (!string.IsNullOrWhiteSpace(searchObject.NameGte))
        //    //{
        //    //    query = query.Where(x => x.Name.StartsWith(searchObject.NameGte));
        //    //}

        //    //if (!string.IsNullOrWhiteSpace(searchObject.LocationGte))
        //    //{
        //    //    query = query.Where(x => x.Location.StartsWith(searchObject.LocationGte));
        //    //}

        //    //if (searchObject.Elevation > 0)
        //    //{
        //    //    query = query.Where(x => x.Elevation == searchObject.Elevation);
        //    //}

        //    //ovo je samo za npr za proizvode
        //    if (!string.IsNullOrEmpty(searchObject.FTS))
        //    {
        //        query = query.Where(x => x.Name.Contains(searchObject.FTS));
        //    }

        //    var list = query.ToList();
        //    result = Mapper.Map(list, result);
        //    return result;
        //}

        //public Model.LiftType Insert(LiftTypeRequest request)
        //{
        //    Database.LiftType entity = new Database.LiftType();
        //    Mapper.Map(request, entity);

        //    Context.Add(entity);
        //    Context.SaveChanges();

        //    return Mapper.Map<Model.LiftType>(entity);
        //}

        //public Model.LiftType Update(int id, LiftTypeRequest request)
        //{
        //    var entity = Context.LiftTypes.Find(id);

        //    Mapper.Map(request, entity);
        //    Context.SaveChanges();

        //    return Mapper.Map<Model.LiftType>(entity);

        //}
    }
}
