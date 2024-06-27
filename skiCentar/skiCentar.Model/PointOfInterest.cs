namespace skiCentar.Model
{
    public class PointOfInterest
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public int? CategoryId { get; set; }

        public decimal? LocationX { get; set; }

        public decimal? LocationY { get; set; }

        public int? ResortId { get; set; }

        public string Description { get; set; } = null!;

        public virtual PointOfInterestCategory? Category { get; set; }

        public virtual Resort? Resort { get; set; }
    }
}
