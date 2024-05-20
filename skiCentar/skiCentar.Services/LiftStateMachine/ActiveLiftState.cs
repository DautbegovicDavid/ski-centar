using MapsterMapper;
using skiCentar.Services.Database;

namespace skiCentar.Services.LiftStateMachine
{
    public class ActiveLiftState : BaseLiftState
    {
        public ActiveLiftState(SkiCenterContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

    }
}
