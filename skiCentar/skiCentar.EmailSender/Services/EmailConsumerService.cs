// skiCentar.EmailSender/Services/EmailConsumerService.cs
using EasyNetQ;
using RabbitMQ.Client;
using skiCentar.Model;

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
        var bus = RabbitHutch.CreateBus("host=localhost");

        await bus.PubSub.SubscribeAsync<Proizvod>("seminarski rad", async msg =>
        {
            Console.WriteLine($"Received message: {msg.Naziv}");

            string recipientEmail = "dautbeg@outlook.com"; // Replace with the recipient's email from msg if available
            string token = Guid.NewGuid().ToString();
            string verificationLink = $"https://localhost:5000/verify?token={token}";
            await _emailService.SendVerificationEmailAsync("dautbeg@outlook.com", verificationLink);

        });
    }
    private void RabbitMQ_ConnectionShutdown(object sender, ShutdownEventArgs e) { }
}
