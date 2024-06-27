namespace skiCentar.Model.Requests
{
    public class PointOfInterestUpsertRequest
    {
        public string Name { get; set; } = null!;

        public int? CategoryId { get; set; }

        public decimal? LocationX { get; set; }

        public decimal? LocationY { get; set; }

        public int? ResortId { get; set; }

        public string Description { get; set; } = null!;

    }
}
