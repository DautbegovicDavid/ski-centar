using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;


[ApiController]
[Route("api/[controller]")]
public class RecommendationsController : ControllerBase
{
    private readonly RecommendationsService _recommendationsService;

    public RecommendationsController(RecommendationsService recommendationsService)
    {
        _recommendationsService = recommendationsService;

    }

    [HttpGet("{userId}")]
    public Task<ActionResult<IEnumerable<PointOfInterest>>> GetRecommendations(int userId)
    {
 
        return Task.FromResult<ActionResult<IEnumerable<PointOfInterest>>>(Ok(_recommendationsService.Recommend(userId)));
    }
    }
