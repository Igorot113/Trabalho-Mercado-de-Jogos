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
    // Obtém as dimensões da tela para a responsividade
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    // Lógica responsiva para as colunas
    int crossAxisCount = 2;
    double aspectRatio = 1.8;

    if (screenWidth >= 900) {
      // Monitores e tablets deitados
      crossAxisCount = 4;
      aspectRatio = 1.5;
    } else if (screenWidth >= 600) {
      // Tablets em pé
      crossAxisCount = 3;
      aspectRatio = 1.5;
    } else if (screenWidth < 360) {
      // Smartphones muito pequenos
      crossAxisCount = 1;
      aspectRatio = 2.5; // Cartão mais largo para preencher a única coluna
    } else {
      // Smartphones padrão
      crossAxisCount = 2;
      aspectRatio = 1.2; // Reduzido do 1.8 original para não ficar achatado demais no celular
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Minha Biblioteca'), centerTitle: true),
      // SafeArea protege o RefreshIndicator e a lista nas bordas do aparelho
      body: SafeArea(
        child: RefreshIndicator(
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
                      height: size.height * 0.7,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            snapshot.error.toString().replaceFirst(
                                  'Exception: ',
                                  '',
                                ),
                            textAlign: TextAlign.center,
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
                      height: size.height * 0.7,
                      child: const Center(
                        child: Text('Sua biblioteca ainda esta vazia.'),
                      ),
                    ),
                  ],
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GridView.builder(
                  // Alterado para um padding vertical mais equilibrado
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: aspectRatio,
                    crossAxisSpacing: 12, // Um pouco mais de espaço horizontal
                    mainAxisSpacing: 12, // Um pouco mais de espaço vertical
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}