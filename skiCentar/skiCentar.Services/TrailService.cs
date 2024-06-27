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
            if (searchObject.isDifficultyIncluded == true)
            {
                query = query.Include(x => x.Difficulty);
            }

            if (searchObject.isResortIncluded == true)
            {
                query = query.Include(x => x.Resort);
            }

            if (searchObject.areTrailLocationsIncluded == true)
            {
                query = query.Include(x => x.TrailLocations);
            }

            if (searchObject.resortId > 0)
            {
                query = query.Where(x => x.ResortId == searchObject.resortId);
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

            if (request.TrailLocations != null)
            {
                var locationSet = Context.Set<TrailLocation>();
                request.TrailLocations.ForEach(f =>
                {
                    f.TrailId = entity.Id;
                    var locationEntity = Mapper.Map<TrailLocation>(f);
                    locationSet.Add(locationEntity);
                    Context.SaveChanges();

                });
            }

            return Mapper.Map<Model.Trail>(entity);
        }

        public override Model.Trail Update(int id, TrailUpsertRequest request)
        {
            var set = Context.Set<Trail>();

            var entity = set.Find(id);

            Mapper.Map(request, entity);

            Context.SaveChanges();
            if (request.TrailLocations != null)
            {
                var locationSet = Context.Set<TrailLocation>();

                // Get existing locations for the lift
                var existingLocations = locationSet.Where(l => l.TrailId == id).ToList();

                // Process new locations from the request
                foreach (var newLocation in request.TrailLocations)
                {
                    newLocation.TrailId = entity.Id;
                    var existingLocation = existingLocations.FirstOrDefault(l => l.LocationX == newLocation.LocationX && l.LocationY == newLocation.LocationY);

                    if (existingLocation == null)
                    {
                        // Add new location
                        var locationEntity = Mapper.Map<TrailLocation>(newLocation);
                        locationSet.Add(locationEntity);
                    }
                    else
                    {
                        // Update existing location
                        Mapper.Map(newLocation, existingLocation);
                    }
                }

                // Remove locations that are not in the new request
                var newLocationsSet = new HashSet<(decimal?, decimal?)>(request.TrailLocations.Select(l => (l.LocationX, l.LocationY)));
                var locationsToRemove = existingLocations.Where(l => !newLocationsSet.Contains((l.LocationX, l.LocationY))).ToList();
                locationSet.RemoveRange(locationsToRemove);

                Context.SaveChanges();
            }

            return Mapper.Map<Model.Trail>(entity);
        }
    }
}
