import 'dart:convert';

import 'package:app_mercado_de_jogos/data/jogo_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5022/api';

  Future<Map<String, dynamic>> login({
    required String login,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'login': login, 'password': password}),
    );

    final data = _decodeResponse(response);

    if (response.statusCode != 200) {
      throw Exception(data['message'] ?? 'Erro ao fazer login.');
    }

    return data;
  }

  Future<void> cadastrar({
    required String nome,
    required String email,
    required String username,
    required String dataNascimento,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': nome,
        'email': email,
        'username': username,
        'dataNascimento': dataNascimento,
        'password': password,
      }),
    );

    final data = _decodeResponse(response);

    if (response.statusCode != 200) {
      throw Exception(data['message'] ?? 'Erro ao cadastrar usuario.');
    }
  }

  Future<List<Jogo>> buscarJogos() async {
    final response = await http.get(Uri.parse('$baseUrl/Games'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar jogos.');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => Jogo.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> adicionarJogoBiblioteca({
    required int usuarioId,
    required int jogoId,
  }) async {
    final response = await http.post(
      Uri.parse(
        '$baseUrl/Biblioteca/adicionar?usuarioId=$usuarioId&jogoId=$jogoId',
      ),
    );

    if (response.statusCode == 200) return;

    final data = _decodeResponse(response);
    throw Exception(data['message'] ?? 'Erro ao adicionar jogo a biblioteca.');
  }

  Future<List<Jogo>> buscarBiblioteca(int usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Biblioteca/$usuarioId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar biblioteca.');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data.whereType<Map<String, dynamic>>().map(Jogo.fromJson).toList();
  }

  Future<void> removerJogoBiblioteca({
    required int usuarioId,
    required int jogoId,
  }) async {
    final response = await http.delete(
      Uri.parse(
        '$baseUrl/Biblioteca/remover?usuarioId=$usuarioId&jogoId=$jogoId',
      ),
    );

    if (response.statusCode == 200) return;

    final data = _decodeResponse(response);
    throw Exception(data['message'] ?? 'Erro ao remover jogo da biblioteca.');
  }

  Map<String, dynamic> _decodeResponse(http.Response response) {
    if (response.body.isEmpty) return {};

    final data = jsonDecode(response.body);
    if (data is Map<String, dynamic>) return data;

    return {'message': data.toString()};
  }
}
