using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class DailyWeatherService : BaseCRUDService<Model.DailyWeather, DailyWeatherSearchObject, DailyWeather, DailyWeatherUpsertRequest, DailyWeatherUpsertRequest>, IDailyWeatherService
    {
        public DailyWeatherService(SkiCenterContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<DailyWeather> AddFilter(DailyWeatherSearchObject searchObject, IQueryable<DailyWeather> query)
        {
            query = base.AddFilter(searchObject, query);

            if (searchObject.TemperatureFrom.HasValue)
            {
                query = query.Where(x => x.Temperature >= searchObject.TemperatureFrom);
            }

            if (searchObject.TemperatureTo.HasValue)
            {
                query = query.Where(x => x.Temperature <= searchObject.TemperatureTo);
            }

            if (searchObject.SnowHeightFrom.HasValue)
            {
                query = query.Where(x => x.SnowHeight >= searchObject.SnowHeightFrom);
            }

            if (searchObject.SnowHeightTo.HasValue)
            {
                query = query.Where(x => x.SnowHeight <= searchObject.SnowHeightTo);
            }

            if (searchObject.DateFrom.HasValue && searchObject.DateFrom != DateTime.MinValue)
            {
                query = query.Where(x => x.Date >= searchObject.DateFrom);
            }

            if (searchObject.DateTo.HasValue && searchObject.DateTo != DateTime.MinValue)
            {
                var toDate = searchObject.DateTo.Value.Date.AddDays(1).AddTicks(-1);
                query = query.Where(x => x.Date <= toDate);
            }

            query = query.Include(i => i.Resort);

            query = query.OrderByDescending(x => x.Date);


            return query;
        }
    }
}
