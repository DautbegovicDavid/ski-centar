using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;
using skiCentar.Services.LiftStateMachine;
using System.Linq.Dynamic.Core;

namespace skiCentar.Services
{
    public class LiftService : BaseCRUDService<Model.Lift, LiftSearchObject, Database.Lift, LiftInsertRequest, LiftInsertRequest>, ILiftService
    {
        ILogger<LiftService> _logger;
        public BaseLiftState BaseLiftState { get; set; }
        public LiftService(SkiCenterContext context, IMapper mapper, BaseLiftState baseLiftState, ILogger<LiftService> logger) : base(context, mapper)
        {
            BaseLiftState = baseLiftState;
            _logger = logger;
        }
        public override IQueryable<Lift> AddFilter(LiftSearchObject searchObject, IQueryable<Lift> query)
        {
            query = base.AddFilter(searchObject, query);
            if (!string.IsNullOrWhiteSpace(searchObject.NameGTE))
            {
                query = query.Where(x => x.Name.StartsWith(searchObject.NameGTE));
            }
            if (searchObject.isLiftTypeIncluded == true)
            {
                query = query.Include(x => x.LiftType);
            }

            if (searchObject.isResortIncluded == true)
            {
                query = query.Include(x => x.Resort).Include(x => x.Resort);
            }

            return query;
        }

        public override Model.Lift Insert(LiftInsertRequest request)
        {
            var state = BaseLiftState.CreateState("initial");
            return state.Insert(request);
        }

        public override Model.Lift Update(int id, LiftInsertRequest request)
        {
            var entity = GetById(id);
            var state = BaseLiftState.CreateState(entity.StateMachine);
            return state.Update(id, request);
        }

        public Model.Lift Activate(int id)
        {
            var entity = GetById(id);
            var state = BaseLiftState.CreateState(entity.StateMachine);
            return state.Activate(id);
        }

        public Model.Lift Edit(int id)
        {
            var entity = GetById(id);
            var state = BaseLiftState.CreateState(entity.StateMachine);
            return state.Edit(id);
        }

        public Model.Lift Hide(int id)
        {
            var entity = GetById(id);
            var state = BaseLiftState.CreateState(entity.StateMachine);
            return state.Hide(id);
        }

        public List<string> AllowedActions(int id)
        {
            _logger.LogInformation($"Allowed actions called for:{id}");

            if (id <= 0)
            {
                var state = BaseLiftState.CreateState("initial");
                return state.AllowedActions(null);
            }
            else
            {
                var entity = Context.Lifts.Find(id);
                var state = BaseLiftState.CreateState(entity.StateMachine);
                return state.AllowedActions(entity);
            }

        }
    }
}
