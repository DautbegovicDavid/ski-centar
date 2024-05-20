using MapsterMapper;
using Microsoft.Extensions.DependencyInjection;
using skiCentar.Model.Requests;
using skiCentar.Services.Database;

namespace skiCentar.Services.LiftStateMachine
{
    public class BaseLiftState//primjer za proizvode
    {
        public SkiCenterContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public IServiceProvider ServiceProvider { get; set; }

        public BaseLiftState(SkiCenterContext context, IMapper mapper, IServiceProvider serviceProvider)
        {
            Context = context;
            Mapper = mapper;
            ServiceProvider = serviceProvider;
        }
        public virtual Model.Lift Insert(LiftInsertRequest request)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Model.Lift Update(int id, LiftInsertRequest request)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Model.Lift Activate(int id)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Model.Lift Hide(int id)
        {
            throw new Exception("Method not allowed");
        }

        public BaseLiftState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "initial":
                    return ServiceProvider.GetService<InitialLiftState>();
                case "draft":
                    return ServiceProvider.GetService<DraftLiftState>();
                case "active":
                    return ServiceProvider.GetService<ActiveLiftState>();
                default: throw new Exception("state not recognized");
            }
        }
    }
}
//initial, draft, active, hidden, active - primjer za proizvode
