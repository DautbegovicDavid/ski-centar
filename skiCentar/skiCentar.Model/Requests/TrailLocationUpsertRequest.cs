namespace skiCentar.Model.Requests
{
    public class TrailLocationUpsertRequest
    {
        public int? TrailId { get; set; }

        public decimal? LocationX { get; set; }

        public decimal? LocationY { get; set; }
    }
}
