using MapsterMapper;
using skiCentar.Model.Requests;
using skiCentar.Services.Database;

namespace skiCentar.Services.LiftStateMachine
{
    public class InitialLiftState : BaseLiftState
    {
        public InitialLiftState(SkiCenterContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override Model.Lift Insert(LiftUpsertRequest request)
        {
            var set = Context.Set<Lift>();
            var entity = Mapper.Map<Lift>(request);
            entity.StateMachine = "draft";
            set.Add(entity);
            Context.SaveChanges();

            if (request.LiftLocations != null)
            {
                var locationSet = Context.Set<LiftLocation>();
                request.LiftLocations.ForEach(f =>
                {
                    f.LiftId = entity.Id;
                    var locationEntity = Mapper.Map<LiftLocation>(f);
                    locationSet.Add(locationEntity);
                    Context.SaveChanges();

                });
            }

            return Mapper.Map<Model.Lift>(entity);
        }

        public override List<string> AllowedActions(Lift entity)
        {
            return new List<string> { nameof(Insert) };
        }
    }
}
