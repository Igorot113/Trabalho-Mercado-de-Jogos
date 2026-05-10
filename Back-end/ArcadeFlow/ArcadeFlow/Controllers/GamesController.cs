using ArcadeFlow.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ArcadeFlow.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GamesController : ControllerBase
    {
        private readonly AppDbContext _context;
        public GamesController(AppDbContext context) 
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var jogos = await _context.Games.ToListAsync();
            return Ok(jogos);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var jogo = await _context.Games.FindAsync(id);

            if (jogo == null) return NotFound(new { message = "Jogo não encontrado" });

            return Ok(jogo);
        }
    }
}
