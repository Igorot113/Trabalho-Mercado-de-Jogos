using ArcadeFlow.Models;
using CsvHelper;
using CsvHelper.Configuration;
using System.Formats.Asn1;
using System.Globalization;

namespace ArcadeFlow.Data
{
    public class CsvSeeder
    {
        private readonly AppDbContext _context;

        public CsvSeeder(AppDbContext context)
        {
            _context = context;
        }

        public async Task ImportarJogosDoCsv(string caminhoArquivo)
        {
            // Configuração para ler o CSV (ponto e vírgula ou vírgula)
            var config = new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                Delimiter = ",", // Mude para ";" se o seu CSV usar ponto e vírgula
                HasHeaderRecord = true,
            };

            using var reader = new StreamReader(caminhoArquivo);
            using var csv = new CsvReader(reader, config);

            // Lê todos os registros do CSV e converte para uma lista de objetos Game
            var games = csv.GetRecords<Game>().ToList();

            foreach (var game in games)
            {
                // Verifica se o jogo já existe para não dar erro de chave duplicada
                var existe = await _context.Games.FindAsync(game.Id);
                if (existe == null)
                {
                    _context.Games.Add(game);
                }
            }

            await _context.SaveChangesAsync();
        }
    }
}
