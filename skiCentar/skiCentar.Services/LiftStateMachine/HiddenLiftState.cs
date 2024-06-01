using MapsterMapper;
using skiCentar.Services.Database;

namespace skiCentar.Services.LiftStateMachine
{
    public class HiddenLiftState : BaseLiftState
    {
        public HiddenLiftState(SkiCenterContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override Model.Lift Edit(int id)
        {
            var set = Context.Set<Lift>();

            var entity = set.Find(id);

            entity.StateMachine = "draft";

            Context.SaveChanges();

            return Mapper.Map<Model.Lift>(entity);
        }

        public override List<string> AllowedActions(Lift entity)
        {
            return new List<string> { nameof(Edit) };
        }

    }
}
