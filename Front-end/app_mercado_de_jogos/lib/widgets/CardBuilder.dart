// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Cardbuilder extends StatelessWidget {
  final int index;
  final PageController controller;

  const Cardbuilder({super.key, required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Envolvemos o Container no LayoutBuilder para reagir ao espaço que o PageView dá a ele
        return LayoutBuilder(
          builder: (context, constraints) {
            // Verifica se o card foi espremido na horizontal ou na vertical
            final bool isEstreito = constraints.maxWidth < 150;
            final bool isCurto = constraints.maxHeight < 150;

            // Define tamanhos dinâmicos baseados no espaço
            final double iconSize = isEstreito || isCurto ? 35 : 50;
            final double fontSize = isEstreito || isCurto ? 14 : 18;
            final double margemVertical = isCurto ? 10 : 20;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: margemVertical),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  // Suavizei a sombra usando Colors.black26 para um visual mais elegante e moderno
                  BoxShadow(
                    color: Colors.black26, 
                    blurRadius: 10, 
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                // Um padding de segurança interno para o conteúdo nunca encostar nas bordas
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min, // Evita que a coluna tente crescer infinitamente
                    children: [
                      Icon(
                        Icons.shopping_bag, 
                        size: iconSize, 
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 10),
                      // Flexible + FittedBox garantem que o texto reduza em vez de dar erro
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Produto ${index + 1}",
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}