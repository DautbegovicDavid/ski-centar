using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using skiCentar.Model.Requests;
using skiCentar.Services;
using Stripe;

[Route("api/[controller]")]
[ApiController]
[Authorize]

public class PaymentsController : ControllerBase
{
    private readonly IConfiguration _configuration;
    private readonly IPaymentService _paymentService;

    public PaymentsController(IConfiguration configuration, IPaymentService paymentService)
    {
        _configuration = configuration;
        _paymentService = paymentService;
        StripeConfiguration.ApiKey = _configuration["Stripe:SecretKey"];
    }

    [HttpPost("create-payment-intent")]
    public async Task<IActionResult> CreatePaymentIntent([FromBody] PaymentIntentCreateRequest request)
    {
        var result = await _paymentService.CreatePaymentIntent(request);

        if (result.Success)
        {
            return Ok(result.Data);
        }

        return BadRequest(result.Message);
    }

    [HttpPost("save-payment")]
    public async Task<IActionResult> SavePaymentData([FromBody] TicketPurchaseCreateRequest request)
    {
        try
        {
            var savedPayment = await _paymentService.SavePayment(request);
            return Ok(savedPayment);
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }
}
