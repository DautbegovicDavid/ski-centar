using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using skiCentar.Services.Database;
using Microsoft.ML.Trainers;
using MapsterMapper;


public class RecommendationsService
{
    private readonly SkiCenterContext _context;
    public IMapper Mapper { get; set; }


    public RecommendationsService(SkiCenterContext context, IMapper mapper)
    {
        _context = context;
        Mapper = mapper;

    }
    public class PoiEntry
    {
        [KeyType(count: 20)]
        public uint poiId { get; set; }

        [KeyType(count: 20)]
        public uint coPoiId { get; set; }

        public float Label { get; set; } = 1;
    }

    public class CoPoi_prediction
    {
        public float Score { get; set; }
    }

    static object isLocked = new object();
    static MLContext mlContext;
    static ITransformer model = null;

    public List<skiCentar.Model.PointOfInterest> Recommend(int userId)
    {
        List<skiCentar.Model.PointOfInterest> result = new List<skiCentar.Model.PointOfInterest>();

        var userInteractions = _context.UserPoiInteractions
            .Include(x => x.PointOfInterest)
            .Include(x=>x.PointOfInterest.Category)
            .Where(x => x.UserId == userId)
            .ToList();

        if (userInteractions.Count == 0)
            return GetPopularPois(5);

        var userPoiIds = userInteractions.Select(x => x.PoiId).Distinct().ToList();

        int poiId = userPoiIds.Count > 1 ? userPoiIds[new Random().Next(userPoiIds.Count)] : userPoiIds.First();

        lock (isLocked)
        {
            if (mlContext == null)
            {
                mlContext = new MLContext();

                var interactionData = _context.UserPoiInteractions
                    .Include(x => x.PointOfInterest)
                    .ToList();

                var data = new List<PoiEntry>();

                foreach (var interaction in interactionData)
                {
                    var relatedPoiIds = interactionData
                        .Where(x => x.PoiId != interaction.PoiId)
                        .Select(x => x.PoiId)
                        .ToList();

                    foreach (var relatedPoi in relatedPoiIds)
                    {
                        data.Add(new PoiEntry
                        {
                            poiId = (uint)interaction.PoiId,
                            coPoiId = (uint)relatedPoi,
                            Label = 1 
                        });
                    }
                }

                var trainData = mlContext.Data.LoadFromEnumerable(data);
                var options = new MatrixFactorizationTrainer.Options
                {
                    MatrixColumnIndexColumnName = nameof(PoiEntry.poiId),
                    MatrixRowIndexColumnName = nameof(PoiEntry.coPoiId),
                    LabelColumnName = nameof(PoiEntry.Label),
                    LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                    Alpha = 0.01,
                    Lambda = 0.025,
                    NumberOfIterations = 100,
                    C = 0.00001
                };

                var estimator = mlContext.Recommendation().Trainers.MatrixFactorization(options);
                model = estimator.Fit(trainData);
            }
        }

        var allPois = _context.PointOfInterests.ToList();

        var predictionResults = new List<Tuple<PointOfInterest, float>>();

        var predictionEngine = mlContext.Model.CreatePredictionEngine<PoiEntry, CoPoi_prediction>(model);
        foreach (var poi in allPois)
        {
            var prediction = predictionEngine.Predict(new PoiEntry
            {
                poiId = (uint)poiId, 
                coPoiId = (uint)poi.Id 
            });

            predictionResults.Add(new Tuple<PointOfInterest, float>(poi, prediction.Score));
        }

        var topRecommendations = predictionResults
            .OrderByDescending(x => x.Item2)
            .Take(5)
            .Select(x => x.Item1)
            .ToList();

        foreach (var poi in topRecommendations)
        {
            var mappedPoi = new skiCentar.Model.PointOfInterest
            {
                Id = poi.Id,
                CategoryId = poi.CategoryId,
                Name = poi.Name,
                Description = poi.Description,
                LocationX = poi.LocationX,
                LocationY = poi.LocationY,

            };

            result.Add(mappedPoi);
        }

        return result;  
    }

    public List<skiCentar.Model.PointOfInterest> GetPopularPois(int count)
    {
        var popularPois = _context.UserPoiInteractions
            .GroupBy(x => x.PoiId)
            .OrderByDescending(g => g.Count()) 
            .Take(count) 
            .Select(g => g.Key) 
            .ToList();

        var poiDetails = _context.PointOfInterests
            .Where(p => popularPois.Contains(p.Id))
            .ToList();

        var result = new List<skiCentar.Model.PointOfInterest>();

        foreach (var poi in poiDetails)
        {
            var mappedPoi = new skiCentar.Model.PointOfInterest
            {
                Id = poi.Id,
                CategoryId = poi.CategoryId,
                Name = poi.Name,
                Description = poi.Description,
                LocationX = poi.LocationX,
                LocationY = poi.LocationY,
            };

            result.Add(mappedPoi);
        }

        return result;
    }
}
