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

        public override Model.Lift Insert(LiftInsertRequest request)
        {
            var set = Context.Set<Lift>();
            var entity = Mapper.Map<Lift>(request);
            entity.StateMachine = "draft";
            set.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<Model.Lift>(entity);
        }

        public override List<string> AllowedActions(Lift entity)
        {
            return new List<string> { nameof(Insert) };
        }
    }
}
