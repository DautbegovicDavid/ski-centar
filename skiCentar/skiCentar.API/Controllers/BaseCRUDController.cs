using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    // kakko dobiti metod aiz icrud servica ? CASTING
    [Route("api/[controller]")]
    [ApiController]
    public class BaseCRUDController<TModel, TSearch, TInsert, TUpdate> : BaseController<TModel, TSearch> where TSearch : BaseSearchObject where TModel : class
    {
        public BaseCRUDController(ICRUDService<TModel, TSearch, TInsert, TUpdate> service) : base(service)
        {
        }

        //[HttpGet]
        //public PagedResult<TModel> GetList([FromQuery] TSearch searchObject)
        //{
        //    return _service.GetPaged(searchObject);
        //}
        [HttpPost]
        public TModel Insert(TInsert request)
        {
            return (_service as ICRUDService<TModel, TSearch, TInsert, TUpdate>).Insert(request);
        }

        [HttpPut("{id}")]
        public TModel Update(int id, TUpdate request)
        {
            return (_service as ICRUDService<TModel, TSearch, TInsert, TUpdate>).Update(id, request);
        }
    }
}
