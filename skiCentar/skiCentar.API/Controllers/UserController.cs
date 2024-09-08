using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : BaseCRUDController<Model.User, UserSearchObject, UserUpsertRequest, UserUpsertRequest>
    {
        public UserController(IUserService service) : base(service)
        {
        }
        [HttpPut("verify/{id}")]
        public Model.User Verify(int id)
        {
            return (_service as IUserService).VerifyUser(id);
        }
        [Authorize]
        [HttpPost("employee")]
        public Model.User Employee([FromBody] EmployeeUpsertRequest request)
        {
            return (_service as IUserService).AddEmployee(request);
        }
        [Authorize]
        [HttpGet("info")]
        public dynamic GetUserInfo()
        {
            string token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");

            var tokenHandler = new JwtSecurityTokenHandler();
            var jwtToken = tokenHandler.ReadJwtToken(token);

            Claim userIdClaim = jwtToken.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier);

            if (userIdClaim != null)
            {
                int userId;
                if (int.TryParse(userIdClaim.Value, out userId))
                {
                    Model.User user = (_service as IUserService).GetById(userId);

                    return Ok(user);
                }
            }

            return BadRequest("Invalid token or user ID not found.");
        }
    }
}
