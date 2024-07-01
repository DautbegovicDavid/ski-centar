using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface ITicketTypeService : ICRUDService<Model.TicketType, TicketTypeSearchObject, TicketTypeUpsertRequest, TicketTypeUpsertRequest>
    {
    }
}
