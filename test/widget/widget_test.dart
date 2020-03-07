import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_auth_benchmark/main.dart';

void main() {
  FirebaseAuthenticationApp app;

  setUp(() {
    app = FirebaseAuthenticationApp();
  });

  void checkEachKeyOneWidget(List<Key> keys) {
    for (final Key key in keys) {
      expect(find.byKey(key), findsOneWidget);
    }
  }

  testWidgets('Finds two TextFormFields', (tester) async {
    await tester.pumpWidget(app);

    Map<Type, int> typesByNumberOfWidgets = {
      TextFormField: 2,
      FlatButton: 3,
    };

    typesByNumberOfWidgets.forEach((Type type, int numberOfWidgets) {
      expect(find.byType(type), findsNWidgets(numberOfWidgets));
    });
  });

  testWidgets('Finds an email and a password fields', (tester) async {
    await tester.pumpWidget(app);

    List<Key> fieldsKeys = [
      Key('email_field'),
      Key('password_field'),
    ];

    checkEachKeyOneWidget(fieldsKeys);
  });

  testWidgets('Finds a forgot password, a sign up and a login buttons',
      (tester) async {
    await tester.pumpWidget(app);

    List<Key> buttonsKeys = [
      Key('forgot_password_button'),
      Key('signin_button'),
      Key('login_button'),
    ];

    checkEachKeyOneWidget(buttonsKeys);
  });
}
