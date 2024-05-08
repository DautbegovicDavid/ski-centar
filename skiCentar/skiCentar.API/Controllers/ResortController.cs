﻿using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ResortController : ControllerBase
    {
        protected IResortService _service;

        public ResortController(IResortService service)
        {
            _service = service;
        }

        [HttpGet]
        public PagedResult<Resort> GetList([FromQuery] ResortSearchObject searchObject)
        {
            return _service.GetList(searchObject);
        }
        [HttpPost]
        public Resort Insert(ResortInsertRequest request)
        {
            return _service.Insert(request);
        }

        [HttpPut("{id}")]
        public Resort Update(int id, ResortInsertRequest request)
        {
            return _service.Update(id, request);
        }
    }
}
