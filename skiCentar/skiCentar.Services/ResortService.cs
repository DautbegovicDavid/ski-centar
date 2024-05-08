using MapsterMapper;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;
using System.Linq.Dynamic.Core;

namespace skiCentar.Services
{
    public class ResortService : IResortService
    {
        public SkiCenterContext Context { get; set; }
        public IMapper Mapper { get; set; }

        public ResortService(SkiCenterContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public virtual Model.PagedResult<Model.Resort> GetList(ResortSearchObject searchObject)
        {
            List<Model.Resort> result = new List<Model.Resort>();

            var query = Context.Resorts.AsQueryable();

            if (!string.IsNullOrWhiteSpace(searchObject.NameGte))
            {
                query = query.Where(x => x.Name.StartsWith(searchObject.NameGte));
            }

            if (!string.IsNullOrWhiteSpace(searchObject.LocationGte))
            {
                query = query.Where(x => x.Location.StartsWith(searchObject.LocationGte));
            }

            if (searchObject.Elevation > 0)
            {
                query = query.Where(x => x.Elevation == searchObject.Elevation);
            }

            //ovo je samo za npr za proizvode
            if (!string.IsNullOrEmpty(searchObject.FTS))
            {
                query = query.Where(x => x.Name.Contains(searchObject.FTS) || x.Location.Contains(searchObject.FTS));
            }
            int count = query.Count();


            var list = query.ToList();
            result = Mapper.Map(list, result);
            Model.PagedResult<Model.Resort> response = new Model.PagedResult<Model.Resort>();
            response.ResultList = result;
            response.Count = count;
            return response;
        }

        public Model.Resort Insert(ResortInsertRequest request)
        {
            Database.Resort entity = new Database.Resort();
            Mapper.Map(request, entity);

            Context.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<Model.Resort>(entity);
        }

        public Model.Resort Update(int id, ResortInsertRequest request)
        {
            var entity = Context.Resorts.Find(id);

            Mapper.Map(request, entity);
            Context.SaveChanges();

            return Mapper.Map<Model.Resort>(entity);

        }
    }
}
