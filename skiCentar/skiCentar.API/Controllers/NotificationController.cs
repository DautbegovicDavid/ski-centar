using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.Requests;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationsController : ControllerBase
    {
        [HttpPost("send")]
        public async Task<IActionResult> SendNotification([FromBody] NotificationUpsertRequest request)
        {
            await FirebaseService.SendNotificationToAllDevices(request.Title, request.Body);
            return Ok("Notification sent to all devices.");
        }
    }
}
