import 'dart:convert';
import 'screen_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = TextEditingController();
  final senhaController = TextEditingController();

  bool carregando = false;

  void fazerLogin() {
    print('Login realizado');
  }

  @override
  void dispose() {
    loginController.dispose();
    senhaController.dispose();
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
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xE6FFFFFF),
              border: Border.all(
                color: Colors.white,
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
                  ),
                ),
                const SizedBox(height: 60),

                TextField(
                  controller: loginController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail ou username',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: carregando ? null : fazerLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D47A1),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    carregando ? 'Entrando...' : 'Entrar',
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
  );
}
}
