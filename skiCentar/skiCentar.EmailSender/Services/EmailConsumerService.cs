// skiCentar.EmailSender/Services/EmailConsumerService.cs
using EasyNetQ;
using RabbitMQ.Client;
using skiCentar.Model;

public class EmailConsumerService : BackgroundService
{
    private readonly IConnection _connection;
    private IModel _channel;
    private readonly EmailService _emailService;

    public EmailConsumerService(EmailService emailService)
    {
        //var factory = new ConnectionFactory
        //{
        //    HostName = "rabbitmq", // Ensure this matches your RabbitMQ server's hostname
        //    UserName = "guest", // Default username
        //    Password = "guest", // Default password
        //    VirtualHost = "/",
        //    DispatchConsumersAsync = true
        //};
        //// create connection  
        //_connection = factory.CreateConnection();

        //// create channel  
        //_channel = _connection.CreateModel();

        ////_channel.ExchangeDeclare("demo.exchange", ExchangeType.Topic);
        //_channel.QueueDeclare("Reservation_added", false, false, false, null);
        ////_channel.QueueBind("demo.queue.log", "demo.exchange", "demo.queue.*", null);
        //_channel.BasicQos(0, 1, false);

        //_connection.ConnectionShutdown += RabbitMQ_ConnectionShutdown;
        _emailService = emailService;


    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                using (var bus = RabbitHutch.CreateBus($"host=rabbitmq;virtualHost=/;username=guest;password=guest"))
                {
                    bus.PubSub.Subscribe<string>("New_Reservations", HandleMessage);
                    Console.WriteLine("Listening for reservations.");
                    await Task.Delay(TimeSpan.FromSeconds(7), stoppingToken);
                }


            }
            catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
            {
                // Gracefully handle cancellation
                break;
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Console.WriteLine($"Error in RabbitMQ listener: {ex.Message}");
            }
        }
    }

    private async Task HandleMessage(string reservation)
    {
        Console.WriteLine($"Email sent: {reservation}");

        // we just print this message   
        await _emailService.SendVerificationEmailAsync("dautbeg@outlook.com", "none");


    }

    private async Task HandleMessageAsync(string message)
    {
        // Implementation for sending email
        await _emailService.SendVerificationEmailAsync("dautbeg@outlook.com", "none");
        Console.WriteLine($"Email sent: {message}");
        //return Task.CompletedTask;
    }

    private async Task HandleMessage(Proizvod reservation)
    {
        Console.WriteLine($"Email sent: jebarte led");

        // we just print this message   

    }

    private void RabbitMQ_ConnectionShutdown(object sender, ShutdownEventArgs e) { }
}
