import 'package:flutter_test/flutter_test.dart';

import 'package:app_mercado_de_jogos/main.dart';

void main() {
  testWidgets('mostra a tela de login', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('ArcadeFlow'), findsOneWidget);
    expect(find.text('Entre na sua conta'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });
}
