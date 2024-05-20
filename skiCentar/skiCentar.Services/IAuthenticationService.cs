using skiCentar.Model;
namespace skiCentar.Services
{

    public interface IAuthenticationService
    {
        Task<ServiceResult> Login(UserLogin request);
        Task<ServiceResult> Register(UserLogin request);

    }
}
