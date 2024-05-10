﻿using Microsoft.AspNetCore.Mvc;
using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;
using skiCentar.Services;

namespace skiCentar.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LiftController : BaseCRUDController<Lift, LiftSearchObject, LiftInsertRequest, LiftInsertRequest>
    {
        public LiftController(ILiftService service) : base(service)
        {
        }
    }
}