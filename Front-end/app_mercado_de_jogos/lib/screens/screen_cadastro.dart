import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final nomeCompController = TextEditingController();
  final dataNascController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  bool carregando = false;

  void fazerCadastro() {
    print('Cadastro realizado');
  }

  @override
  void dispose() {
    nomeCompController.dispose();
    dataNascController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF0D47A1),
          image: DecorationImage(
            image: AssetImage('assents/fundo.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(24),
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
                    const SizedBox(height: 60),

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
                      controller: dataNascController,
                      keyboardType: TextInputType.datetime,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Data de nascimento',
                        border: OutlineInputBorder(),
                      ),
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

                    ElevatedButton(
                      onPressed: carregando ? null : fazerCadastro,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 72, 0, 255),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        carregando ? 'Cadastrando...' : 'Cadastrar',
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ja tenho uma conta'),
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
