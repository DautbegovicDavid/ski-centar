using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using skiCentar.Model.SearchObjects;
using skiCentar.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace skiCentar.Services
{
    public class TicketPurchaseService : BaseService<Model.TicketPurchase, TicketPurchaseSearchObject, TicketPurchase>, ITicketPurchaseService
    {

        public TicketPurchaseService(SkiCenterContext context, IMapper mapper) : base(context, mapper) { }

        public override IQueryable<TicketPurchase> AddFilter(TicketPurchaseSearchObject searchObject, IQueryable<TicketPurchase> query)
        {
            query = base.AddFilter(searchObject, query);

  
            query = query.Include(x => x.Ticket.TicketType.TicketTypeSeniority);

            if (searchObject.UserId > 0)
            {
                query = query.Include(x => x.User);

                query = query.Where(x => x.UserId == searchObject.UserId);
            }

            if (searchObject.TicketTypeId > 0)
            {
                query = query.Where(x => x.Ticket.TicketTypeId == searchObject.TicketTypeId);
            }

            if (searchObject.TotalPriceFrom > 0)
            {
                query = query.Where(x => x.TotalPrice >= searchObject.TotalPriceFrom);
            }

            if (searchObject.TotalPriceTo > 0)
            {
                query = query.Where(x => x.TotalPrice <= searchObject.TotalPriceTo);
            }

            if (searchObject.PurchaseDateFrom.HasValue && searchObject.PurchaseDateFrom != DateTime.MinValue)
            {
                query = query.Where(x => x.PurchaseDate >= searchObject.PurchaseDateFrom);
            }

            if (searchObject.PurchaseDateTo.HasValue && searchObject.PurchaseDateTo != DateTime.MinValue)
            {
                var toDate = searchObject.PurchaseDateTo.Value.Date.AddDays(1).AddTicks(-1);
                query = query.Where(x => x.PurchaseDate <= toDate);
            }
            return query;
        }
    }
}