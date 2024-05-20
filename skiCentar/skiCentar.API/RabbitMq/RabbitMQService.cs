// skiCentar.API/Services/RabbitMQService.cs
using RabbitMQ.Client;
using System.Text;

public interface IRabbitMQService
{
    void Publish(string queueName, string message);
}

public class RabbitMQService : IRabbitMQService
{
    private readonly IConnectionFactory _connectionFactory;

    public RabbitMQService()
    {
        _connectionFactory = new ConnectionFactory
        {
            HostName = "rabbitmq",
            DispatchConsumersAsync = true
        };

    }

    public void Publish(string queueName, string message)
    {

        using var connection = _connectionFactory.CreateConnection();
        using var channel = connection.CreateModel();

        channel.QueueDeclare(queue: queueName,
                             durable: false,
                             exclusive: false,
                             autoDelete: false,
                             arguments: null);

        var body = Encoding.UTF8.GetBytes(message);

        channel.BasicPublish(exchange: "",
                             routingKey: queueName,
                             basicProperties: null,
                             body: body);

        //var bus = RabbitHutch.CreateBus("host=rabbitmq");

        //bus.PubSub.Publish(new Proizvod()
        //{
        //    id = 2,
        //    Naziv = "Monitor",
        //    Cijena = 200
        //});
    }
}
