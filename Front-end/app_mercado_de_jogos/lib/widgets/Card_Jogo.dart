import 'package:flutter/material.dart';

class CardJogo extends StatelessWidget {
  final String titulo;
  final double preco;
  final String urlCapa;
  final String categoria;

  const CardJogo({
    super.key,
    required this.titulo,
    required this.preco,
    required this.urlCapa,
    required this.categoria,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
