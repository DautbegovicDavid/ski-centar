using skiCentar.Model.Requests;
using skiCentar.Model.SearchObjects;

namespace skiCentar.Services
{
    public interface ITicketService : ICRUDService<Model.Ticket, TicketSearchObject, TicketUpsertRequest, TicketUpsertRequest>
    {
    }
}
