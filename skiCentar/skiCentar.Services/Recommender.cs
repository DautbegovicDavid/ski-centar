using Microsoft.ML;
using Microsoft.ML.Data;

namespace skiCentar.Services
{
    public class PointOfInterestData
    {
        public string Description { get; set; }
        public string Category { get; set; }
    }

    public class PointOfInterestPrediction
    {
        [ColumnName("Score")]
        public float[] Score { get; set; }
    }

    public class Recommender
    {
        private readonly MLContext _mlContext;
        private readonly ITransformer _model;
        private readonly IDataView _dataView;

        public Recommender(IEnumerable<PointOfInterestData> data)
        {
            _mlContext = new MLContext();

            _dataView = _mlContext.Data.LoadFromEnumerable(data);

            var pipeline = _mlContext.Transforms.Text.FeaturizeText(outputColumnName: "DescriptionFeatures", inputColumnName: nameof(PointOfInterestData.Description))
                .Append(_mlContext.Transforms.Text.FeaturizeText(outputColumnName: "CategoryFeatures", inputColumnName: nameof(PointOfInterestData.Category)))
                .Append(_mlContext.Transforms.Concatenate("Features", "DescriptionFeatures", "CategoryFeatures"))
                .Append(_mlContext.Clustering.Trainers.KMeans(featureColumnName: "Features", numberOfClusters: 5));

            _model = pipeline.Fit(_dataView);
        }

        public List<int> GetRecommendations(PointOfInterestData point, List<PointOfInterestData> data)
        {
            var predictionEngine = _mlContext.Model.CreatePredictionEngine<PointOfInterestData, PointOfInterestPrediction>(_model);

            var pointFeatures = new PointOfInterestData
            {
                Description = point.Description,
                Category = point.Category
            };

            var prediction = predictionEngine.Predict(pointFeatures);

            var scores = new List<(int, float)>();
            for (int i = 0; i < data.Count; i++)
            {
                var score = predictionEngine.Predict(data[i]).Score;
                scores.Add((i, score[0]));
            }

            scores.Sort((x, y) => y.Item2.CompareTo(x.Item2));
            var topRecommendations = scores.Take(5).Select(x => x.Item1).ToList();
            return topRecommendations;
        }
    }
}
