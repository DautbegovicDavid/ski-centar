using EasyNetQ;
using skiCentar.Model.Notification;

namespace skiCentar.EmailSenderService;
public class EmailConsumerService : BackgroundService
{
    private readonly EmailService _emailService;
    private readonly string _rabbitMqHost;

    public EmailConsumerService(EmailService emailService, IConfiguration configuration)
    {
        _emailService = emailService;
        _rabbitMqHost = Environment.GetEnvironmentVariable("RABBITMQ_HOST")
                        ?? configuration["RabbitMQ:Host"];

        Console.WriteLine(_rabbitMqHost);
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
        var host = $"host={_rabbitMqHost}";
        var bus = RabbitHutch.CreateBus(host);
        Console.WriteLine($"listening:");

        await bus.PubSub.SubscribeAsync<EmailNotification>("EmailNotification", async notification =>
        {
            Console.WriteLine($"Received message: {notification.Email} , {notification.VerificationCode}");
            string recipientEmail = notification.Email;
            string token = notification.VerificationCode;
            string verificationLink = $"https://dautbegovicdavid.github.io/ski-center-verification-page/?id={token}";
            await _emailService.SendVerificationEmailAsync(recipientEmail, verificationLink);

        });
    }
}

