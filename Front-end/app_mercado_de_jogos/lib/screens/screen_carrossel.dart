import 'package:app_mercado_de_jogos/widgets/Card_Jogo.dart';
import 'package:flutter/material.dart';

class ScreenCarrossel extends StatelessWidget {
  const ScreenCarrossel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ArcadeFlow Store"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const CardJogo(
              titulo: "Nome do Jogo",
              preco: 150.00,
              urlCapa: "https://via.placeholder.com/150",
              categoria: "Ação",
            );
          },
        ),
      ),
    );
  }
}
