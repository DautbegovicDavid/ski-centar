using System;

namespace skiCentar.Model
{
    public class DailyWeather
    {
        public int Id { get; set; }

        public DateTime? Date { get; set; }

        public decimal? Temperature { get; set; }

        public decimal? Precipitation { get; set; }

        public decimal? WindSpeed { get; set; }

        public decimal? Humidity { get; set; }

        public string? WeatherCondition { get; set; }

        public decimal? SnowHeight { get; set; }

        public int? ResortId { get; set; }

        public virtual Resort? Resort { get; set; }
    }
}
