using EasyNetQ;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using skiCentar.Model;
using skiCentar.Model.Notification;
using skiCentar.Services.Database;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace skiCentar.Services
{
    public class AuthenticationService : IAuthenticationService
    {
        public SkiCenterContext Context { get; set; }
        private readonly IConfiguration Configuration;

        public AuthenticationService(SkiCenterContext context, IConfiguration configuration)
        {
            Context = context;
            Configuration = configuration;

        }

        public async Task<ServiceResult> Register(UserLogin request)
        {
            if (Context.Users.Any(u => u.Email == request.Email))
                return await Task.FromResult(new ServiceResult { Success = false, Message = "User already exists." });
            var user = new Database.User
            {
                Email = request.Email,
                Password = BCrypt.Net.BCrypt.HashPassword(request.Password),
                UserRoleId = 3,
                IsVerified = false,
            };

            Context.Users.Add(user);
            await Context.SaveChangesAsync();

            var verificationCode = Guid.NewGuid().ToString();

            var userVerification = new UserVerification
            {
                UserId = user.Id,
                VerificationCode = verificationCode,
                Email = request.Email,
            };

            Context.UserVerifications.Add(userVerification);
            await Context.SaveChangesAsync();

            var host = $"host={Environment.GetEnvironmentVariable("RABBITMQ_HOST")}";
            var bus = RabbitHutch.CreateBus(host);
            var message = new EmailNotification { Email = request.Email, VerificationCode = verificationCode };
            Console.WriteLine(message);
            bus.PubSub.Publish(message);

            return await Task.FromResult(new ServiceResult { Success = true, Message = "User registered successfully." });
        }

        public Task<ServiceResult> Login(UserLogin request)
        {
            var user = Context.Users.Include(i => i.UserRole).SingleOrDefault(u => u.Email == request.Email);

            if (user == null || !BCrypt.Net.BCrypt.Verify(request.Password, user.Password))
                return Task.FromResult(new ServiceResult { Success = false, Message = "Invalid credentials." });

            if (user.IsVerified == false)
                return Task.FromResult(new ServiceResult { Success = false, Message = "Email not confirmed." });

            var tokenString = GenerateJwtToken(user);
            return Task.FromResult(new ServiceResult
            {
                Success = true,
                Data = new { token = tokenString }
            });
        }

        public Task<ServiceResult> VerifyUser(VerifyUser request)
        {
            var verificationEntity = Context.UserVerifications.FirstOrDefault(u => u.VerificationCode == request.VerificationCode);

            if (verificationEntity == null)
                return Task.FromResult(new ServiceResult { Success = false, Message = "Error" });

            var userEntity = Context.Users.FirstOrDefault(e => e.Id == verificationEntity.UserId);

            if (userEntity == null)
                return Task.FromResult(new ServiceResult { Success = false, Data = new { message = "Error" } });

            userEntity.IsVerified = true;

            Context.UserVerifications.Remove(verificationEntity);
            Context.SaveChanges();

            return Task.FromResult(new ServiceResult { Success = true, Message = "Email address succesfully verified." });
        }

        private string GenerateJwtToken(Database.User user)
        {
            var claims = new[]
            {
            new Claim(JwtRegisteredClaimNames.Sub, user.Email),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new Claim(ClaimTypes.Role, user.UserRole!.Name),
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["Jwt:Key"]!));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                Configuration["Jwt:Issuer"],
                Configuration["Jwt:Audience"],
                claims,
                expires: DateTime.Now.AddMinutes(Convert.ToDouble(Configuration["Jwt:ExpireMinutes"])),
                signingCredentials: creds);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}
