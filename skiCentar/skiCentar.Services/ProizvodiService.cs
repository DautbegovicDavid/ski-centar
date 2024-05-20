using EasyNetQ;
using skiCentar.Model;
using skiCentar.Services.Database;

namespace skiCentar.Services
{
    public class ProizvodiService : IProizvodiService
    {
        public SkiCenterContext Context { get; set; }
        public ProizvodiService(SkiCenterContext context)
        {
            Context = context;
        }


        public virtual List<Model.Resort> GetList()
        {
            return null;

            //var bus = RabbitHutch.CreateBus("host=localhost");

            //bus.PubSub.Publish(new Proizvod()
            //{
            //    id = 2,
            //    Naziv = "Monitor",
            //    Cijena = 200
            //});
            //Debugger.Launch();
        }

        List<Proizvod> IProizvodiService.GetList()
        {
            var bus = RabbitHutch.CreateBus("host=localhost");

            bus.PubSub.Publish(new Proizvod()
            {
                id = 2,
                Naziv = "Monitor",
                Cijena = 200
            });
            throw new NotImplementedException();
        }
    }
}
