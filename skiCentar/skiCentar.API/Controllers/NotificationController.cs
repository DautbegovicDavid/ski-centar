using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.Requests;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]

    public class NotificationsController : ControllerBase
    {
        private readonly FirebaseService _firebaseService;

        public NotificationsController(FirebaseService firebaseService)
        {
            _firebaseService = firebaseService;
        }

        [HttpPost("send")]
        public async Task<IActionResult> SendNotification([FromBody] NotificationUpsertRequest request)
        {
            await _firebaseService.SendNotificationToAllDevices(request.Title, request.Body);
            return Ok("Notification sent to all devices.");
        }
    }
}
