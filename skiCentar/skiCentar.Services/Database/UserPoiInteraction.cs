namespace skiCentar.Services.Database
{
    public class UserPoiInteraction
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int PoiId { get; set; }
        public string InteractionType { get; set; }
        public DateTime InteractionTimestamp { get; set; }
        public User User { get; set; }
        public PointOfInterest PointOfInterest { get; set; }
    }
}
