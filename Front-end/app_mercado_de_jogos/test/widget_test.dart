import 'package:flutter_test/flutter_test.dart';

import 'package:app_mercado_de_jogos/main.dart';

void main() {
  testWidgets('mostra a tela de login', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('E-mail ou username'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });
}
