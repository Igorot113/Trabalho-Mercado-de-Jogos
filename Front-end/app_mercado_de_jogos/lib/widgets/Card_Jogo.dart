// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CardJogo extends StatelessWidget {
  final String titulo;
  final double preco;
  final String urlCapa;
  final String categoria;
  final VoidCallback? onAdicionar;
  final String textoBotao;
  final Color corBotao;

  const CardJogo({
    super.key,
    required this.titulo,
    required this.preco,
    required this.urlCapa,
    required this.categoria,
    this.onAdicionar,
    this.textoBotao = 'Adicionar',
    this.corBotao = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder permite que o Card tome decisões baseadas na largura disponível para ele,
    // e não na largura da tela inteira. Excelente para componentes que vão em GridViews.
    return LayoutBuilder(
      builder: (context, constraints) {
        // Verifica se o card está muito estreito (ex: 3 colunas em um celular pequeno)
        final bool isEstreito = constraints.maxWidth < 140;
        
        // Ajusta paddings dinamicamente
        final double paddingCard = isEstreito ? 6.0 : 10.0;

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.network(
                    urlCapa,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(paddingCard),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoria,
                      style: TextStyle(
                        color: Colors.grey, 
                        fontSize: isEstreito ? 10 : 12,
                      ),
                      maxLines: 1,
                      // ellipsis adiciona "..." caso a categoria seja muito longa
                      overflow: TextOverflow.ellipsis, 
                    ),
                    Text(
                      titulo,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isEstreito ? 13 : 15,
                      ),
                      maxLines: 1,
                      // Impede que títulos longos quebrem o design do card
                      overflow: TextOverflow.ellipsis, 
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "R\$ ${preco.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: isEstreito ? 12 : 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (onAdicionar != null) ...[
                      SizedBox(height: isEstreito ? 4 : 8),
                      SizedBox(
                        width: double.infinity,
                        // Reduz levemente a altura do botão se o card for pequeno
                        height: isEstreito ? 32 : 40,
                        child: ElevatedButton(
                          onPressed: onAdicionar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: corBotao,
                            foregroundColor: Colors.white,
                            // Reduz o espaçamento interno do botão se necessário
                            padding: EdgeInsets.symmetric(horizontal: isEstreito ? 4 : 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // FittedBox garante que o texto "Adicionar" encolha em vez de 
                          // causar erro de overflow se o botão ficar muito fino
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              textoBotao,
                              style: TextStyle(fontSize: isEstreito ? 12 : 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}