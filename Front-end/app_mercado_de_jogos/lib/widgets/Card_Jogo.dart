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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoria,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  "R\$ ${preco.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (onAdicionar != null) ...[
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onAdicionar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: corBotao,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(textoBotao),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
