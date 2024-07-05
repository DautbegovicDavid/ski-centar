using skiCentar.Model;
using skiCentar.Model.Requests;

namespace skiCentar.Services
{
    public interface IPaymentService
    {
        Task<ServiceResult> CreatePaymentIntent(PaymentIntentCreateRequest request);
        Task<TicketPurchase> SavePayment(TicketPurchaseCreateRequest request);
    }
}
