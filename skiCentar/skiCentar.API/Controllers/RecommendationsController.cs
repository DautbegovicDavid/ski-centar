using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Services;

[ApiController]
[Route("api/[controller]")]
public class RecommendationsController : ControllerBase
{
    private readonly RecommendationsService _recommendationsService;
    private readonly Recommender _recommender;

    public RecommendationsController(RecommendationsService recommendationsService)
    {
        _recommendationsService = recommendationsService;
    }

    [HttpGet("{userId}")]
    public async Task<ActionResult<IEnumerable<skiCentar.Model.PointOfInterest>>> GetRecommendations(int userId)
    {
        var userInteractions = await _recommendationsService.GetUserInteractionsAsync(userId);
        var allPoints = await _recommendationsService.GetPointsOfInterestAsync();

        var userInterests = userInteractions.Select(ui => new PointOfInterestData
        {
            Description = ui.PointOfInterest.Description,
            Category = ui.PointOfInterest.Category.Name
        }).ToList();

        var recommender = new Recommender(allPoints.Select(p => new PointOfInterestData
        {
            Description = p.Description,
            Category = p.Category.Name
        }).ToList());

        var recommendations = new List<skiCentar.Model.PointOfInterest>();

        foreach (var interest in userInterests)
        {
            var recommendedIndexes = recommender.GetRecommendations(interest, allPoints.Select(p => new PointOfInterestData
            {
                Description = p.Description,
                Category = p.Category.Name
            }).ToList());

            var recommendedPoints = recommendedIndexes
                .Select(index => allPoints.FirstOrDefault(p => p.Id == index))
                .Where(p => p != null)
                .ToList();

            recommendations.AddRange(recommendedPoints.Select(p => new skiCentar.Model.PointOfInterest
            {
                Id = p.Id,
                Description = p.Description,
                Category = new PointOfInterestCategory(p.Category.Id, p.Category.Name)
            }));
        }

        return Ok(recommendations);
    }

}
