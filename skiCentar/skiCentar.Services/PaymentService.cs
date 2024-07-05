using MapsterMapper;
using skiCentar.Model;
using skiCentar.Model.Requests;
using skiCentar.Services.Database;
using Stripe;

namespace skiCentar.Services
{
    public class PaymentService : IPaymentService
    {
        public SkiCenterContext Context { get; set; }
        private IMapper Mapper;

        public PaymentService(SkiCenterContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;

        }
        public async Task<ServiceResult> CreatePaymentIntent(PaymentIntentCreateRequest request)
        {
            var options = new PaymentIntentCreateOptions
            {
                Amount = request.Amount,
                Currency = request.Currency,
            };

            var service = new PaymentIntentService();
            var paymentIntent = await service.CreateAsync(options);

            return new ServiceResult
            {
                Success = true,
                Data = new { clientSecret = paymentIntent.ClientSecret }
            };
        }

        public async Task<Model.TicketPurchase> SavePayment(TicketPurchaseCreateRequest request)
        {
            var set = Context.Set<Database.TicketPurchase>();
            var entity = Mapper.Map<Database.TicketPurchase>(request);
            set.Add(entity);
            await Context.SaveChangesAsync();
            return Mapper.Map<Model.TicketPurchase>(entity);
        }
    }
}
