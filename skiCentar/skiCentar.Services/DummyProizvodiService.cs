using skiCentar.Model;

namespace skiCentar.Services
{
    public class DummyProizvodiService : ProizvodiService
    {
        public new List<Proizvod> List = new List<Proizvod>()
        {
            new Proizvod()
            {
                id = 1,
                Naziv="Laptop",
                Cijena = 100
            },
        };
        public override List<Proizvod> GetList()
        {
            return List;
        }
    }
}
