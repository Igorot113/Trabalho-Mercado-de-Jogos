using Microsoft.EntityFrameworkCore;
using ArcadeFlow.Models;

namespace ArcadeFlow.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Game> Games { get; set; }
        public DbSet<Biblioteca> Bibliotecas { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Usuario>(entity =>
            {
                entity.ToTable("usuarios");

                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Nome).HasColumnName("nome");
                entity.Property(e => e.Email).HasColumnName("email");
                entity.Property(e => e.Username).HasColumnName("username");
                entity.Property(e => e.SenhaHash).HasColumnName("senhahash");
                entity.Property(e => e.DataNascimento).HasColumnName("data_nascimento");
                entity.Property(e => e.DataCriacao).HasColumnName("data_criacao");
            });

            modelBuilder.Entity<Game>(entity =>
            {
                entity.ToTable("games");
                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.Titulo).HasColumnName("titulo");
                entity.Property(e => e.Descricao).HasColumnName("descricao");
                entity.Property(e => e.Preco).HasColumnName("preco");
                entity.Property(e => e.UrlCapa).HasColumnName("urlcapa");
                entity.Property(e => e.Categoria).HasColumnName("categoria");
            });

            modelBuilder.Entity<Biblioteca>(entity =>
            {
                entity.ToTable("biblioteca");
                entity.Property(e => e.Id).HasColumnName("id");
                entity.Property(e => e.UsuarioId).HasColumnName("usuarioid");
                entity.Property(e => e.JogoId).HasColumnName("jogoid");
                entity.Property(e => e.DataAquisicao).HasColumnName("dataaquisicao");

            });
        }
    }
}
