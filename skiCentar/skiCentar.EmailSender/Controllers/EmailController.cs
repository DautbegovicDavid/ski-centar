using Microsoft.AspNetCore.Mvc;

namespace EmailVerificationApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VerificationController : ControllerBase
    {
        private readonly EmailService _emailService;

        public VerificationController(EmailService emailService)
        {
            _emailService = emailService;
        }

        [HttpPost("send")]
        public async Task<IActionResult> SendVerificationEmail([FromBody] string email)
        {
            if (string.IsNullOrEmpty(email))
            {
                return BadRequest("Email is required.");
            }

            var verificationLink = $"https://localhost:5000/verify?token=token={Guid.NewGuid()}";
            await _emailService.SendVerificationEmailAsync(email, verificationLink);

            return Ok("Verification email sent.");
        }
    }
}
