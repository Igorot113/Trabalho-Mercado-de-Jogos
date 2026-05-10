using System.ComponentModel.DataAnnotations.Schema;
using CsvHelper.Configuration.Attributes;

namespace ArcadeFlow.Models
{
    public class Game
    {
        [Name("AppID")]
        public int Id { get; set; }

        [Name("Name")]
        public string Titulo { get; set; } = string.Empty;

        [Name("Supported languages")]
        public string? Descricao { get; set; }

        [Name("Price")]
        public decimal Preco { get; set; }

        [Name("Website")]
        public string? UrlCapa { get; set; } 

        [Name("Tags")]
        public string Categoria { get; set; } = string.Empty;
    }
}
