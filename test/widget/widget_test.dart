import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_auth_benchmark/main.dart';

void main() {
  FirebaseAuthenticationApp app;

  setUp(() {
    app = FirebaseAuthenticationApp();
  });

  testWidgets('Finds an email field', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.byKey(Key('email_field')), findsOneWidget);
  });

  testWidgets('Finds a password field', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.byKey(Key('email_field')), findsOneWidget);
  });
}
