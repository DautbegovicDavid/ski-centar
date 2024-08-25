using System;

namespace skiCentar.Model.Requests
{
    public class UserPioInteractionUpsertRequest
    {
        public int UserId { get; set; }
        public int PoiId { get; set; }
        public string InteractionType { get; set; }
        public DateTime InteractionTimestamp { get; set; }
    }
}
