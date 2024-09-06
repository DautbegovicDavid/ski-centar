using Google.Apis.Auth.OAuth2;
using Newtonsoft.Json;
using System.Text;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace skiCentar.Services
{
    public class FirebaseService
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<FirebaseService> _logger;
        private readonly HttpClient _httpClient;
        private string FCM_SEND_URL;

        public FirebaseService(IConfiguration configuration, ILogger<FirebaseService> logger, HttpClient httpClient)
        {
            _configuration = configuration;
            _logger = logger;
            _httpClient = httpClient;
            FCM_SEND_URL = Environment.GetEnvironmentVariable("FIREBASE_NOTIFICATIONS_URL")
                ?? _configuration["Firebase:Url"];
        }

        public async Task SendNotificationToAllDevices(string title, string body)
        {
            try
            {
                GoogleCredential credential;
                string credPath = Environment.GetEnvironmentVariable("DOTNET_RUNNING_IN_CONTAINER") == "true"
                    ? "/app/firebase-cred.json"
                    : @"..\firebase-cred.json";

                if (!File.Exists(credPath))
                {
                    _logger.LogError($"Firebase credentials file not found at path: {credPath}");
                    return;
                }

                using (var stream = new FileStream(credPath, FileMode.Open, FileAccess.Read))
                {
                    credential = GoogleCredential.FromStream(stream).CreateScoped("https://www.googleapis.com/auth/firebase.messaging");
                }

                var message = new
                {
                    message = new
                    {
                        notification = new
                        {
                            title,
                            body
                        },
                        topic = "allDevices"
                    }
                };

                var jsonMessage = JsonConvert.SerializeObject(message);

                _httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", await credential.UnderlyingCredential.GetAccessTokenForRequestAsync());
                var request = new HttpRequestMessage(HttpMethod.Post, FCM_SEND_URL)
                {
                    Content = new StringContent(jsonMessage, Encoding.UTF8, "application/json")
                };

                var response = await _httpClient.SendAsync(request);

                if (response.IsSuccessStatusCode)
                {
                    _logger.LogInformation("Notification sent successfully.");
                }
                else
                {
                    var responseBody = await response.Content.ReadAsStringAsync();
                    _logger.LogError($"Error sending notification: {response.StatusCode} - {responseBody}");
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to send notification.");
            }
        }
    }
}
