import 'package:flutter/material.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela de Login"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 50),
      ),
    );
  }
}
