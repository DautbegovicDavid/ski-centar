﻿using MapsterMapper;
using skiCentar.Services.Database;

namespace skiCentar.Services.LiftStateMachine
{
    public class ActiveLiftState : BaseLiftState
    {
        public ActiveLiftState(SkiCenterContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
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
            return new List<string> { nameof(Hide) };
        }

    }
}
