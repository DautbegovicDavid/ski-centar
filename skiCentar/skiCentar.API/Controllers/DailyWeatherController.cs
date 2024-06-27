using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DailyWeatherController : BaseCRUDController<DailyWeather, DailyWeatherSearchObject, DailyWeatherUpsertRequest, DailyWeatherUpsertRequest>
    {
        public DailyWeatherController(IDailyWeatherService service) : base(service)
        {
        }
    }
}
