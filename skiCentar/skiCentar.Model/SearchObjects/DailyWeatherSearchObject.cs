using System;

namespace skiCentar.Model.SearchObjects
{
    public class DailyWeatherSearchObject : BaseSearchObject
    {
        public DateTime? DateFrom { get; set; }

        public DateTime? DateTo { get; set; }

        public decimal? TemperatureFrom { get; set; }

        public decimal? TemperatureTo { get; set; }

        public decimal? SnowHeightFrom { get; set; }

        public decimal? SnowHeightTo { get; set; }

        public int? ResortId { get; set; }
    }
}
