using System.ComponentModel.DataAnnotations;


namespace ArcadeFlow.Models
{
    public class Usuario
    {
        [Key]
        public int Id { get; set; }

        [Required, MaxLength(100)]
        public string Nome { get; set; } = string.Empty;

        [Required, EmailAddress]
        public string Email { get; set; } = string.Empty;

        [Required, MaxLength(100)]
        public string Username {  get; set; } = string.Empty;

        [Required]
        public string SenhaHash { get; set; } = string.Empty;

        public DateOnly? DataNascimento { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.UtcNow;

    }
}
