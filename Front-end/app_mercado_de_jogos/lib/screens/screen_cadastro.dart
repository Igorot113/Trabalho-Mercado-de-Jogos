import 'package:app_mercado_de_jogos/services/api_service.dart';
import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final nomeCompController = TextEditingController();
  final usernameController = TextEditingController();
  final dataNascController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();
  final apiService = ApiService();

  bool carregando = false;

  Future<void> fazerCadastro() async {
    if (nomeCompController.text.trim().isEmpty ||
        usernameController.text.trim().isEmpty ||
        dataNascController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        senhaController.text.trim().isEmpty ||
        confirmarSenhaController.text.trim().isEmpty) {
      mostrarMensagem('Preencha todos os campos.');
      return;
    }

    if (senhaController.text != confirmarSenhaController.text) {
      mostrarMensagem('As senhas nao conferem.');
      return;
    }

    setState(() => carregando = true);

    try {
      await apiService.cadastrar(
        nome: nomeCompController.text.trim(),
        email: emailController.text.trim(),
        username: usernameController.text.trim(),
        dataNascimento: dataNascController.text.trim(),
        password: senhaController.text.trim(),
      );

      if (!mounted) return;

      mostrarMensagem('Cadastro realizado com sucesso.');
      Navigator.pop(context);
    } catch (e) {
      mostrarMensagem(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => carregando = false);
    }
  }

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  Future<void> selecionarDataNascimento() async {
    final hoje = DateTime.now();
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: hoje,
    );

    if (dataSelecionada == null) return;

    dataNascController.text = formatarData(dataSelecionada);
  }

  String formatarData(DateTime data) {
    final ano = data.year.toString().padLeft(4, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final dia = data.day.toString().padLeft(2, '0');

    return '$ano-$mes-$dia';
  }

  @override
  void dispose() {
    nomeCompController.dispose();
    usernameController.dispose();
    dataNascController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtém o tamanho da tela para ajustes dinâmicos, se necessário
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF0D47A1),
          image: DecorationImage(
            image: AssetImage('assents/fundo.png'),
            fit: BoxFit.cover, // Alterado de fitWidth para cover para melhor adaptação de fundo
          ),
        ),
        // SafeArea adicionado para proteger contra notches e bordas do sistema
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Container(
                // Substituindo a largura fixa de 350 por BoxConstraints
                constraints: const BoxConstraints(maxWidth: 400),
                width: double.infinity,
                padding: EdgeInsets.all(size.width > 350 ? 24 : 16), // Padding responsivo
                decoration: BoxDecoration(
                  color: const Color.fromARGB(139, 0, 0, 0),
                  border: Border.all(
                    color: const Color.fromARGB(255, 119, 0, 255),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'CADASTRO',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Orbitron',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 89, 0, 255),
                      ),
                    ),
                    const SizedBox(height: 40), // Reduzido ligeiramente para caber melhor em telas pequenas
                    TextField(
                      controller: nomeCompController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Nome completo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: dataNascController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Data de nascimento',
                        border: OutlineInputBorder(),
                      ),
                      onTap: selecionarDataNascimento,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: senhaController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: confirmarSenhaController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Confirmar senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity, // Faz o botão ocupar toda a largura disponível do contêiner
                      height: 50, // Altura confortável para o toque (Touch Target)
                      child: ElevatedButton(
                        onPressed: carregando ? null : fazerCadastro,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 72, 0, 255),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          carregando ? 'Cadastrando...' : 'Cadastrar',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Já tenho uma conta'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}