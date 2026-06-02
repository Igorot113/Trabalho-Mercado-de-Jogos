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
  final searchController = TextEditingController();

  // Variáveis para controlar o estado da tela e a pesquisa
  List<Jogo> todosJogos = [];
  List<Jogo> jogosFiltrados = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    carregarJogos();
    // Adiciona um listener que vai rodar a função de filtro sempre que o texto mudar
    searchController.addListener(_filtrarJogos);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Função que busca os jogos na API
  Future<void> carregarJogos() async {
    try {
      final jogos = await apiService.buscarJogos();
      if (!mounted) return;

      setState(() {
        todosJogos = jogos;
        jogosFiltrados = jogos; // Inicialmente, todos os jogos são exibidos
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
    }
  }

  // Função que filtra a lista baseado no que foi digitado
  void _filtrarJogos() {
    final query = searchController.text.toLowerCase().trim();

    setState(() {
      if (query.isEmpty) {
        jogosFiltrados = todosJogos;
      } else {
        jogosFiltrados = todosJogos.where((jogo) {
          // Busca tanto pelo título quanto pela categoria do jogo
          final titulo = jogo.titulo.toLowerCase();
          final categoria = jogo.categoria.toLowerCase();
          return titulo.contains(query) || categoria.contains(query);
        }).toList();
      }
    });
  }

  Future<void> adicionarJogo(Jogo jogo) async {
    try {
      await apiService.adicionarJogoBiblioteca(
        usuarioId: widget.usuarioId,
        jogoId: jogo.id,
      );

      if (!mounted) return;

      mostrarMensagem('${jogo.titulo} foi adicionado à sua biblioteca.');
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
    final screenWidth = MediaQuery.of(context).size.width;

    // Lógica responsiva das colunas mantida
    int crossAxisCount = 2;
    if (screenWidth >= 900) {
      crossAxisCount = 4;
    } else if (screenWidth >= 600) {
      crossAxisCount = 3;
    } else if (screenWidth < 360) {
      crossAxisCount = 1;
    }

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
      body: SafeArea(
        child: Column(
          children: [
            // BARRA DE PESQUISA
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar jogo ou categoria...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            // Não precisa chamar _filtrarJogos porque o listener já faz isso
                            FocusScope.of(context).unfocus(); // Oculta o teclado
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                ),
              ),
            ),
            
            // CONTEÚDO PRINCIPAL (Lista de Jogos, Loading ou Erro)
            Expanded(
              child: _buildConteudoJogos(crossAxisCount, screenWidth),
            ),
          ],
        ),
      ),
    );
  }

  // Extraí a renderização da tela para um método separado para manter o código limpo
  Widget _buildConteudoJogos(int crossAxisCount, double screenWidth) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }

    if (jogosFiltrados.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum jogo encontrado para esta busca.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: screenWidth < 600 ? 1.0 : 1.3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: jogosFiltrados.length,
      itemBuilder: (context, index) {
        final jogo = jogosFiltrados[index];

        return CardJogo(
          titulo: jogo.titulo,
          preco: jogo.preco,
          urlCapa: jogo.urlCapa,
          categoria: jogo.categoria,
          onAdicionar: () => adicionarJogo(jogo),
        );
      },
    );
  }
}