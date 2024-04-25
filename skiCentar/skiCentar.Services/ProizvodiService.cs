using skiCentar.Model;
using System.Diagnostics;

namespace skiCentar.Services
{
    public class ProizvodiService : IProizvodiService
    {
        public List<Proizvod> List = new List<Proizvod>()
        {
            new Proizvod()
            {
                id = 1,
                Naziv="Laptop",
                Cijena = 100
            },
             new Proizvod()
            {
                id = 2,
                Naziv = "Monitor",
                Cijena = 200
            },
        };
        public virtual List<Proizvod> GetList()
        {
            Debugger.Launch();
            return List;
        }
    }
}
