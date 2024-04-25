using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProizvodiController : ControllerBase
    {
        protected IProizvodiService _service;
        public ProizvodiController(IProizvodiService service)
        {
            _service = service;

        }
        [HttpGet]
        public List<Proizvod> GetList()
        {
            return _service.GetList();

        }

    }
}
