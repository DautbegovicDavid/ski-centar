// See https://aka.ms/new-console-template for more information

using EasyNetQ;
using skiCentar.Model;

var bus = RabbitHutch.CreateBus("host=localhost");

await bus.PubSub.SubscribeAsync<Proizvod>("seminarski rad", msg =>
Console.WriteLine($"alo alo1", msg.Naziv));


await bus.PubSub.SubscribeAsync<Proizvod>("seminarski rad", msg =>
Console.WriteLine($"alo alo1", msg.Naziv));

await bus.PubSub.SubscribeAsync<Proizvod>("seminarski rad 2", msg =>
Console.WriteLine($"alo alo2 ", msg.Naziv));



Console.WriteLine("LIstening to messages, press <return> key to close!");
Console.ReadLine();
