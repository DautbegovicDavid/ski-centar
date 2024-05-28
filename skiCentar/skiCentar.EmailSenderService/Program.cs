using skiCentar.EmailSenderService;
//worker service
IHost host = Host.CreateDefaultBuilder(args)
    .ConfigureServices(services =>
    {
        services.AddHostedService<EmailConsumerService>();
        services.AddTransient<EmailService>();

    })
    .Build();

host.Run();
