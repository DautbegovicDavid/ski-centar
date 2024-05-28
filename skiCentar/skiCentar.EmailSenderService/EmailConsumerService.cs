using EasyNetQ;

namespace skiCentar.EmailSenderService;
public class EmailConsumerService : BackgroundService
{
    private readonly EmailService _emailService;

    public EmailConsumerService(EmailService emailService)
    {
        _emailService = emailService;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                await Listen();
                await Task.Delay(TimeSpan.FromSeconds(7), stoppingToken);
            }
            catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
            {
                Console.WriteLine($"Error in RabbitMQ listener:OperationCanceledException");
                break;
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Console.WriteLine($"Error in RabbitMQ listener: {ex.Message}");
            }
        }
    }

    private async Task Listen()
    {
        var host = "host=rabbitmq";// alo lokalno ostavim lokal host , rabbitmq za docker
        var bus = RabbitHutch.CreateBus("host=localhost");
        Console.WriteLine($"listening:");

        await bus.PubSub.SubscribeAsync<string>("seminarski rad", async msg =>
        {
            Console.WriteLine($"Received message: {msg}");

            string recipientEmail = "dautbeg7@gmail.com"; // Replace with the recipient's email from msg if available
            string token = Guid.NewGuid().ToString();
            string verificationLink = $"https://dautbegovicdavid.github.io/ski-center-verification-page/?id={token}";
            await _emailService.SendVerificationEmailAsync(recipientEmail, verificationLink);

        });
    }
}

