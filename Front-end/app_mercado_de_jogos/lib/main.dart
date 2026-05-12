import 'package:flutter/material.dart';

import 'screens/screen_login.dart';

// Ponto de entrada do app Flutter.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      // A primeira tela aberta pelo app agora é a tela de login.
      home: const LoginScreen(),
    );
  }
}
