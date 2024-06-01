using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticationController : ControllerBase
    {
        private readonly IAuthenticationService _service;
        private readonly IRabbitMQService _rabbitMQService;

        public AuthenticationController(IAuthenticationService service, IRabbitMQService rabbitMQService)
        {
            _service = service;
            _rabbitMQService = rabbitMQService;
        }

        [HttpPost("Register")]
        public async Task<IActionResult> Register([FromBody] UserLogin request)
        {
            var result = await _service.Register(request);
            if (result.Success)
            {
                return Ok(new { message = result.Message });
            }
            return BadRequest(new { message = result.Message });
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Login([FromBody] UserLogin request)
        {
            var result = await _service.Login(request);
            if (result.Success)
            {
                return Ok(new { token = result.Message });
            }

            return Unauthorized(new { message = result.Message });
        }
        [HttpPost("VerifyUser")]
        public async Task<IActionResult> VerifyUser([FromBody] VerifyUser request)
        {
            var result = await _service.VerifyUser(request);
            if (result.Success)
            {
                return Ok(new { message = result.Message });
            }
            return BadRequest(new { message = result.Message });
        }

    }
}
