using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class SkiAccidentService : BaseCRUDService<Model.SkiAccident, SkiAccidentSearchObject, Database.SkiAccident, SkiAccidentUpsertRequest, SkiAccidentUpsertRequest>, ISkiAccidentService
    {
        public SkiAccidentService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<SkiAccident> AddFilter(SkiAccidentSearchObject searchObject, IQueryable<SkiAccident> query)
        {
            var filteredQuery = base.AddFilter(searchObject, query);

            if (searchObject.UserId.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.UserId == searchObject.UserId);
            }

            if (searchObject.TrailId.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.TrailId <= searchObject.TrailId);
            }

            if (searchObject.PeopleInvolvedFrom.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.PeopleInvolved >= searchObject.PeopleInvolvedFrom);
            }

            if (searchObject.PeopleInvolvedTo.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.PeopleInvolved <= searchObject.PeopleInvolvedTo);
            }

            if (searchObject.DateFrom != DateTime.MinValue && searchObject.DateFrom.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.Timestamp >= searchObject.DateFrom);
            }

            if (searchObject.DateTo != DateTime.MinValue && searchObject.DateTo.HasValue)
            {
                var toDate = searchObject.DateTo.Value.AddDays(1).AddTicks(-1);
                filteredQuery = filteredQuery.Where(x => x.Timestamp <= toDate);
            }

            if (searchObject.IsActive.HasValue)
            {
                filteredQuery = filteredQuery.Where(x => x.IsActive == searchObject.IsActive);
            }


            if (filteredQuery.Any(x => x.User != null))
            {
                filteredQuery = filteredQuery
                    .Include(x => x.User)
                    .ThenInclude(user => user.UserDetails);
            }

            filteredQuery = filteredQuery.OrderByDescending(x => x.Timestamp);

            return filteredQuery;
        }
    }
}
