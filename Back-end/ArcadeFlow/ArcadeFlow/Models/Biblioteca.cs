namespace ArcadeFlow.Models
{
    public class Biblioteca
    {
        public int Id { get; set; }

        public int UsuarioId { get; set; }
        public Usuario? Usuario { get; set; }

        public int JogoId { get; set; }
        public Game? Jogo { get; set; }

        public DateTime DataAquisicao { get; set; } = DateTime.UtcNow;
    }
}
