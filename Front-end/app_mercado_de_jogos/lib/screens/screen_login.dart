import 'package:app_mercado_de_jogos/screens/screen_carrossel.dart';
import 'package:app_mercado_de_jogos/screens/screen_cadastro.dart';
import 'package:app_mercado_de_jogos/services/api_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = TextEditingController();
  final senhaController = TextEditingController();
  final apiService = ApiService();

  bool carregando = false;

  Future<void> fazerLogin() async {
    if (loginController.text.trim().isEmpty ||
        senhaController.text.trim().isEmpty) {
      mostrarMensagem('Preencha login e senha.');
      return;
    }

    setState(() => carregando = true);

    try {
      final usuario = await apiService.login(
        login: loginController.text.trim(),
        password: senhaController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ScreenCarrossel(usuarioId: usuario['id'] as int),
        ),
      );
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

  @override
  void dispose() {
    loginController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtém o tamanho da tela para ajustes finos de padding
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF0D47A1),
          image: DecorationImage(
            image: AssetImage('assents/fundo.png'),
            // BoxFit.cover garante que o fundo cubra toda a tela sem distorcer
            fit: BoxFit.cover, 
          ),
        ),
        // SafeArea impede que a interface fique por baixo de elementos do sistema (câmera, relógio)
        child: SafeArea(
          child: Center(
            // SingleChildScrollView é CRUCIAL aqui para o layout não quebrar quando o teclado abrir
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Container(
                // BoxConstraints define uma largura máxima, em vez de uma largura fixa e engessada
                constraints: const BoxConstraints(maxWidth: 400),
                width: double.infinity,
                padding: EdgeInsets.all(size.width > 350 ? 24 : 16),
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
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Orbitron',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 89, 0, 255),
                      ),
                    ),
                    const SizedBox(height: 40), // Reduzido o espaço para dar folga ao teclado
                    TextField(
                      controller: loginController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'E-mail ou username',
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
                    const SizedBox(height: 24),
                    // SizedBox ao redor do botão aumenta a área de toque para o usuário no celular
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: carregando ? null : fazerLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 72, 0, 255),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          carregando ? 'Entrando...' : 'Entrar',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CadastroScreen(),
                          ),
                        );
                      },
                      child: const Text('Criar uma conta'),
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