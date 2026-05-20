class Jogo {
  final int id;
  final String titulo;
  final String descricao;
  final double preco;
  final String urlCapa;
  final String categoria;

  Jogo({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.urlCapa,
    required this.categoria,
  });

  factory Jogo.fromJson(Map<String, dynamic> json) {
    return Jogo(
      id: json['id'] as int,
      titulo: json['titulo'] as String? ?? 'Sem titulo',
      descricao: json['descricao'] as String? ?? '',
      preco: (json['preco'] as num?)?.toDouble() ?? 0,
      urlCapa: json['urlCapa'] as String? ?? 'https://via.placeholder.com/150',
      categoria: json['categoria'] as String? ?? 'Sem categoria',
    );
  }
}
