using ArcadeFlow.Data;
using ArcadeFlow.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ArcadeFlow.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {

        private readonly AppDbContext _context;

        public AuthController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterRequest request)
        {
            if (await _context.Usuarios.AnyAsync(u => u.Email == request.Email || u.Username == request.Username))
            {
                return BadRequest(new { message = "Este E-mail/Username já está cadastrado." });
            }

            var novoUsuario = new Usuario
            {
                Nome = request.Nome,
                Email = request.Email,
                Username = request.Username,
                DataNascimento = request.DataNascimento,
                SenhaHash = BCrypt.Net.BCrypt.HashPassword(request.Password)

            };

            _context.Usuarios.Add(novoUsuario);
            await _context.SaveChangesAsync();

            return Ok(new {message = "Usuário criado com sucesso!"});
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            var usuario = await _context.Usuarios
                .FirstOrDefaultAsync(u => u.Email == request.Login || u.Username == request.Login);

            if (usuario == null || !BCrypt.Net.BCrypt.Verify(request.Password, usuario.SenhaHash))
            {
                return Unauthorized(new { message = "E-mail/Username ou senha inválidos." });
            }

            return Ok(new
            {
                id = usuario.Id,
                nome = usuario.Nome,
                email = usuario.Email,
                username = usuario.Username,
                dataNascimento = usuario.DataNascimento,
            });
        }
    }

    public record RegisterRequest(string Nome, string Email, string Username, DateOnly DataNascimento, string Password);
}
