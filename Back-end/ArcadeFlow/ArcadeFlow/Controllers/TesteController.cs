using ArcadeFlow.Data;
using Microsoft.AspNetCore.Mvc;

namespace ArcadeFlow.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TesteController : ControllerBase
    {

        private readonly AppDbContext _context;

        public TesteController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("importar-csv")]
        public async Task<IActionResult> Importar (int pagina)
        {
            // Coloque o caminho real do seu arquivo aqui
            string caminho = @"C:\Users\Eduardo\Documents\Projetos\games.csv";

            var seeder = new CsvSeeder(_context);
            await seeder.ImportarJogosDoCsv(caminho);

            return Ok("Dados do CSV importados com sucesso para o PostgreSQL!");
        }
    }
}
