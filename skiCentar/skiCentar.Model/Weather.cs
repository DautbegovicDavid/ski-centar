namespace skiCentar.Model
{
    public class WeatherResponse
    {
        public Main main { get; set; }
        public Weather[] weather { get; set; }
        public string Name { get; set; }

        public class Main
        {
            public float Temp { get; set; }
            public float Pressure { get; set; }
            public int Humidity { get; set; }
        }

        public class Weather
        {
            public string Description { get; set; }
            public string Icon { get; set; }
        }
    }
}
