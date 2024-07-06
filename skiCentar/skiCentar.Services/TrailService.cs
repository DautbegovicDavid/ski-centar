using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class TrailService : BaseCRUDService<Model.Trail, TrailSearchObject, Database.Trail, TrailUpsertRequest, TrailUpsertRequest>, ITrailService
    {
        public TrailService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Trail> AddFilter(TrailSearchObject searchObject, IQueryable<Trail> query)
        {
            query = base.AddFilter(searchObject, query);
            if (!string.IsNullOrWhiteSpace(searchObject.NameGTE))
            {
                query = query.Where(x => x.Name.StartsWith(searchObject.NameGTE));
            }
            if (searchObject.IsDifficultyIncluded == true)
            {
                query = query.Include(x => x.Difficulty);
            }

            if (searchObject.IsResortIncluded == true)
            {
                query = query.Include(x => x.Resort);
            }

            if (searchObject.AreTrailLocationsIncluded == true)
            {
                query = query.Include(x => x.TrailLocations);
            }

            if (searchObject.ResortId > 0)
            {
                query = query.Where(x => x.ResortId == searchObject.ResortId);
            }

            if (searchObject.DifficultyId > 0)
            {
                query = query.Where(x => x.DifficultyId == searchObject.DifficultyId);
            }
            return query;
        }

        public override Model.Trail Insert(TrailUpsertRequest request)
        {
            var set = Context.Set<Trail>();
            var entity = Mapper.Map<Trail>(request);
            set.Add(entity);
            Context.SaveChanges();
            return Mapper.Map<Model.Trail>(entity);
        }

        public override Model.Trail Update(int id, TrailUpsertRequest request)
        {
            var locationSet = Context.Set<TrailLocation>();

            var existingLocations = locationSet.Where(loc => loc.TrailId == id).ToList();

            locationSet.RemoveRange(existingLocations);

            var set = Context.Set<Trail>();

            var entity = set.Find(id);

            Mapper.Map(request, entity);

            Context.SaveChanges();

            return Mapper.Map<Model.Trail>(entity);
        }
    }
}
