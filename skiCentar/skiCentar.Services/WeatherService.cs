using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using skiCentar.Model;

namespace skiCentar.Services
{
    public class WeatherService
    {
        private readonly HttpClient _httpClient;
        private readonly string _apiKey;
        private readonly string _baseUrl = "https://api.openweathermap.org/data/2.5/weather";

        public WeatherService(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _apiKey = Environment.GetEnvironmentVariable("OPENWEATHER_API_KEY") ?? configuration["OpenWeather:ApiKey"];
        }

        public async Task<WeatherResponse> GetWeatherAsync(string mountain, string city)
        {
            var response = await _httpClient.GetAsync($"{_baseUrl}?q={mountain}&appid={_apiKey}&units=metric");
            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
            {
                response = await _httpClient.GetAsync($"{_baseUrl}?q={city}&appid={_apiKey}&units=metric");
            }
            response.EnsureSuccessStatusCode();
            var content = await response.Content.ReadAsStringAsync();
            return JsonConvert.DeserializeObject<WeatherResponse>(content);
        }
    }
}
