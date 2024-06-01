using MapsterMapper;
using Microsoft.Extensions.DependencyInjection;
using skiCentar.Model;
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
            throw new UserException("Method not allowed");
        }

        public virtual Model.Lift Update(int id, LiftInsertRequest request)
        {
            throw new UserException("Method not allowed");
        }

        public virtual Model.Lift Activate(int id)
        {
            throw new UserException("Method not allowed");
        }

        public virtual Model.Lift Hide(int id)
        {
            throw new UserException("Method not allowed");
        }

        public virtual Model.Lift Edit(int id)
        {
            throw new UserException("Method not allowed");
        }

        public virtual List<string> AllowedActions(Database.Lift entity)
        {
            throw new UserException("Method not allowed");
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
                case "hidden":
                    return ServiceProvider.GetService<HiddenLiftState>();
                default: throw new Exception("state not recognized");
            }
        }
    }
}
//initial, draft, active, hidden, active - primjer za proizvode
