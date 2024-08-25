using Google.Apis.Auth.OAuth2;
using Newtonsoft.Json;
using System.Text;

namespace skiCentar.Services
{
    public class FirebaseService
    {
        private const string FCM_SEND_URL = "https://fcm.googleapis.com/v1/projects/notifications-skicenter/messages:send";

        public static async Task SendNotificationToAllDevices(string title, string body)
        {
            GoogleCredential credential;
            using (var stream = new FileStream(@"..\firebase-cred.json", FileMode.Open, FileAccess.Read))
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

            using (var httpClient = new HttpClient())
            {
                httpClient.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", await credential.UnderlyingCredential.GetAccessTokenForRequestAsync());
                var request = new HttpRequestMessage(HttpMethod.Post, FCM_SEND_URL)
                {
                    Content = new StringContent(jsonMessage, Encoding.UTF8, "application/json")
                };

                var response = await httpClient.SendAsync(request);

                if (response.IsSuccessStatusCode)
                {
                    Console.WriteLine("Notification sent successfully.");
                }
                else
                {
                    var responseBody = await response.Content.ReadAsStringAsync();
                    Console.WriteLine($"Error sending notification: {response.StatusCode} - {responseBody}");
                }
            }
        }
    }
}
