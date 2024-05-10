using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;
using System.Linq.Dynamic.Core;

namespace skiCentar.Services
{
    public class LiftService : BaseCRUDService<Model.Lift, LiftSearchObject, Database.Lift, LiftInsertRequest, LiftInsertRequest>, ILiftService
    {
        public LiftService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Lift> AddFilter(LiftSearchObject searchObject, IQueryable<Lift> query)
        {
            query = base.AddFilter(searchObject, query);
            if (!string.IsNullOrWhiteSpace(searchObject.NameGTE))
            {
                query = query.Where(x => x.Name.StartsWith(searchObject.NameGTE));
            }

            if (searchObject.isLiftTypeIncluded == true)
            {
                query = query.Include(x => x.LiftType);
            }

            if (searchObject.isResortIncluded == true)
            {
                query = query.Include(x => x.Resort).Include(x => x.Resort);
            }

            return query;
        }

        //public virtual Model.PagedResult<Model.Lift> GetList(LiftSearchObject searchObject)
        //{
        //    List<Model.Lift> result = new List<Model.Lift>();

        //    var query = Context.Lifts.AsQueryable();

        //    if (!string.IsNullOrWhiteSpace(searchObject.NameGTE))
        //    {
        //        query = query.Where(x => x.Name.StartsWith(searchObject.NameGTE));
        //    }

        //    if (searchObject.isLiftTypeIncluded == true)
        //    {
        //        query = query.Include(x => x.LiftType);
        //    }

        //    if (searchObject.isResortIncluded == true)
        //    {
        //        query = query.Include(x => x.ResortId).Include(x => x.Resort);
        //    }

        //    int count = query.Count();

        //    if (!string.IsNullOrWhiteSpace(searchObject.OrderBy))
        //    {
        //        query = query.OrderBy(searchObject.OrderBy);
        //    }

        //    if (searchObject.Page.HasValue && searchObject.PageSize.HasValue)
        //    {
        //        query = query.Skip(searchObject.Page.Value * searchObject.PageSize.Value).Take(searchObject.PageSize.Value);
        //    }

        //    var list = query.ToList();
        //    result = Mapper.Map(list, result);

        //    Model.PagedResult<Model.Lift> response = new Model.PagedResult<Model.Lift>();
        //    response.ResultList = result;
        //    response.Count = count;
        //    return response;
        //}

        //public Model.Lift Insert(LiftInsertRequest request)
        //{
        //    Database.Lift entity = new Database.Lift();
        //    Mapper.Map(request, entity);

        //    Context.Add(entity);
        //    Context.SaveChanges();

        //    return Mapper.Map<Model.Lift>(entity);
        //}

        //public Model.Lift Update(int id, LiftInsertRequest request)
        //{
        //    var entity = Context.Lifts.Find(id);

        //    Mapper.Map(request, entity);
        //    Context.SaveChanges();

        //    return Mapper.Map<Model.Lift>(entity);

        //}
    }
}
