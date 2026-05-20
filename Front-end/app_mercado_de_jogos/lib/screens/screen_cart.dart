import 'package:app_mercado_de_jogos/data/jogo_model.dart';
import 'package:app_mercado_de_jogos/services/api_service.dart';
import 'package:app_mercado_de_jogos/widgets/Card_Jogo.dart';
import 'package:flutter/material.dart';

class ScreenCart extends StatefulWidget {
  final int usuarioId;

  const ScreenCart({super.key, required this.usuarioId});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  final apiService = ApiService();
  late Future<List<Jogo>> bibliotecaFuture;

  @override
  void initState() {
    super.initState();
    bibliotecaFuture = apiService.buscarBiblioteca(widget.usuarioId);
  }

  Future<void> recarregarBiblioteca() async {
    setState(() {
      bibliotecaFuture = apiService.buscarBiblioteca(widget.usuarioId);
    });
  }

  Future<void> removerJogo(Jogo jogo) async {
    try {
      await apiService.removerJogoBiblioteca(
        usuarioId: widget.usuarioId,
        jogoId: jogo.id,
      );

      if (!mounted) return;

      mostrarMensagem('${jogo.titulo} foi removido da sua biblioteca.');
      recarregarBiblioteca();
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
      appBar: AppBar(title: const Text('Minha Biblioteca'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: recarregarBiblioteca,
        child: FutureBuilder<List<Jogo>>(
          future: bibliotecaFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Text(
                        snapshot.error.toString().replaceFirst(
                          'Exception: ',
                          '',
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            final jogos = snapshot.data ?? [];

            if (jogos.isEmpty) {
              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Center(
                      child: Text('Sua biblioteca ainda esta vazia.'),
                    ),
                  ),
                ],
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.82,
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
                  textoBotao: 'Remover',
                  corBotao: Colors.redAccent,
                  onAdicionar: () => removerJogo(jogo),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
