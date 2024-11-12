using skiCentar.Model;
using skiCentar.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace skiCentar.Services
{
    public interface ITicketPurchaseService: IService<TicketPurchase, TicketPurchaseSearchObject>
    {
    }
}