using MapsterMapper;
using skiCentar.Model.Requests;
using skiCentar.Services.Database;

namespace skiCentar.Services.LiftStateMachine
{
    public class DraftLiftState : BaseLiftState
    {
        public DraftLiftState(SkiCenterContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override Model.Lift Update(int id, LiftUpsertRequest request)//na ovaj nacin dozvolimo update u stanju draft
        {
            var set = Context.Set<Lift>();

            var entity = set.Find(id);

            Mapper.Map(request, entity);

            Context.SaveChanges();
            if (request.LiftLocations != null)
            {
                var locationSet = Context.Set<LiftLocation>();

                // Get existing locations for the lift
                var existingLocations = locationSet.Where(l => l.LiftId == id).ToList();

                // Process new locations from the request
                foreach (var newLocation in request.LiftLocations)
                {
                    newLocation.LiftId = entity.Id;
                    var existingLocation = existingLocations.FirstOrDefault(l => l.LocationX == newLocation.LocationX && l.LocationY == newLocation.LocationY);

                    if (existingLocation == null)
                    {
                        // Add new location
                        var locationEntity = Mapper.Map<LiftLocation>(newLocation);
                        locationSet.Add(locationEntity);
                    }
                    else
                    {
                        // Update existing location
                        Mapper.Map(newLocation, existingLocation);
                    }
                }

                // Remove locations that are not in the new request
                var newLocationsSet = new HashSet<(decimal?, decimal?)>(request.LiftLocations.Select(l => (l.LocationX, l.LocationY)));
                var locationsToRemove = existingLocations.Where(l => !newLocationsSet.Contains((l.LocationX, l.LocationY))).ToList();
                locationSet.RemoveRange(locationsToRemove);

                Context.SaveChanges();
            }

            return Mapper.Map<Model.Lift>(entity);
        }

        public override Model.Lift Activate(int id)
        {
            var set = Context.Set<Lift>();

            var entity = set.Find(id);

            entity.StateMachine = "active";

            Context.SaveChanges();

            return Mapper.Map<Model.Lift>(entity);

        }

        public override Model.Lift Hide(int id)
        {
            var set = Context.Set<Lift>();

            var entity = set.Find(id);

            entity.StateMachine = "hidden";

            Context.SaveChanges();

            return Mapper.Map<Model.Lift>(entity);

        }

        public override List<string> AllowedActions(Lift entity)
        {
            return new List<string> { nameof(Hide), nameof(Activate), nameof(Update) };
        }
    }
}
