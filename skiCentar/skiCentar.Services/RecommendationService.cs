using Microsoft.EntityFrameworkCore;
using skiCentar.Services.Database;

public class RecommendationsService
{
    private readonly SkiCenterContext _context;

    public RecommendationsService(SkiCenterContext context)
    {
        _context = context;
    }

    public async Task<List<PointOfInterest>> GetPointsOfInterestAsync()
    {
        var x = await _context.PointOfInterests
            .Include(p => p.Category)
            .ToListAsync();
        return x;
    }

    public async Task<List<UserPoiInteraction>> GetUserInteractionsAsync(int userId)
    {
        var x = await _context.UserPoiInteractions
            .Where(ui => ui.UserId == userId)
            .Include(ui => ui.PointOfInterest)
            .ThenInclude(p => p.Category)
            .ToListAsync();
        return x;
    }
}
