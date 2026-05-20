import 'package:app_mercado_de_jogos/data/jogo_model.dart';
import 'package:app_mercado_de_jogos/screens/screen_cart.dart';
import 'package:app_mercado_de_jogos/services/api_service.dart';
import 'package:app_mercado_de_jogos/widgets/Card_Jogo.dart';
import 'package:flutter/material.dart';

class ScreenCarrossel extends StatefulWidget {
  final int usuarioId;

  const ScreenCarrossel({super.key, required this.usuarioId});

  @override
  State<ScreenCarrossel> createState() => _ScreenCarrosselState();
}

class _ScreenCarrosselState extends State<ScreenCarrossel> {
  final apiService = ApiService();
  late Future<List<Jogo>> jogosFuture;

  @override
  void initState() {
    super.initState();
    jogosFuture = apiService.buscarJogos();
  }

  Future<void> adicionarJogo(Jogo jogo) async {
    try {
      await apiService.adicionarJogoBiblioteca(
        usuarioId: widget.usuarioId,
        jogoId: jogo.id,
      );

      if (!mounted) return;

      mostrarMensagem('${jogo.titulo} foi adicionado a sua biblioteca.');
    } catch (e) {
      mostrarMensagem(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ArcadeFlow Store"),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Minha biblioteca',
            icon: const Icon(Icons.library_books),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenCart(usuarioId: widget.usuarioId),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Jogo>>(
        future: jogosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString().replaceFirst('Exception: ', ''),
              ),
            );
          }

          final jogos = snapshot.data ?? [];

          if (jogos.isEmpty) {
            return const Center(child: Text('Nenhum jogo encontrado.'));
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: jogos.length,
              itemBuilder: (context, index) {
                final jogo = jogos[index];

                return CardJogo(
                  titulo: jogo.titulo,
                  preco: jogo.preco,
                  urlCapa: jogo.urlCapa,
                  categoria: jogo.categoria,
                  onAdicionar: () => adicionarJogo(jogo),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
