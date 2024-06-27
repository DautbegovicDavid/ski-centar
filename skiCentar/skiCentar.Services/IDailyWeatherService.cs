using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface IDailyWeatherService : ICRUDService<Model.DailyWeather, DailyWeatherSearchObject, DailyWeatherUpsertRequest, DailyWeatherUpsertRequest>
    {
    }
}
