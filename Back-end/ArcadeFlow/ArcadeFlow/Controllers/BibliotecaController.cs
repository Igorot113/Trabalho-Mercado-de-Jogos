using ArcadeFlow.Data;
using ArcadeFlow.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ArcadeFlow.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BibliotecaController : ControllerBase
    {
        private readonly AppDbContext _context;

        public BibliotecaController(AppDbContext context) => _context = context;

        [HttpPost("adicionar")]
        public async Task<IActionResult> AdicionarAoIventario(int usuarioId, int jogoId)
        {
            var jaPossui = await _context.Bibliotecas
                .AnyAsync(b =>  b.UsuarioId == usuarioId && b.JogoId == jogoId);

            if (jaPossui) return BadRequest("Você já possui este jogo.");

            var item = new Biblioteca { UsuarioId = usuarioId, JogoId = jogoId };
            _context.Bibliotecas.Add(item);
            await _context.SaveChangesAsync();


            return Ok("Jogo adicionado à sua biblioteca!");
        }

        [HttpGet("{usuarioId}")]
        public async Task<IActionResult> GetBiblioteca(int usuarioId)
        {
            var meusJogos = await _context.Bibliotecas
                .Where(b => b.UsuarioId == usuarioId)
                .Include(b => b.Jogo)
                .Select(b => b.Jogo)
                .ToListAsync();

            return Ok(meusJogos);
        }
    }
}
