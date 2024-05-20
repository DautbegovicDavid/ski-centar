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

        public override Model.Lift Update(int id, LiftInsertRequest request)//na ovaj nacin dozvolimo update u stanju draft
        {
            var set = Context.Set<Lift>();

            var entity = set.Find(id);

            Mapper.Map(request, entity);

            Context.SaveChanges();

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
    }
}
