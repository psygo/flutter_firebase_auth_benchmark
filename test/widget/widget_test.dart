import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/main.dart';
import 'package:flutter_firebase_auth_benchmark/screens/login_screen.dart';

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

  testWidgets('Checks if the Login Screen has been correctly initialized',
      (tester) async {
    final LoginScreen loginScreen = LoginScreen.defaultLoginScreen;

    MaterialApp wrappedScreen =
        MaterialApp(home: LoginScreen.defaultLoginScreen);

    await tester.pumpWidget(wrappedScreen);

    final StatelessElement extractedLoginScreenElement =
        tester.element(find.byType(LoginScreen));
    final LoginScreen extractedLoginScreen =
        extractedLoginScreenElement.widget as LoginScreen;

    expect(loginScreen, equals(extractedLoginScreen));
  });

  testWidgets('Finds the fields and buttons on the login screen',
      (tester) async {
    await tester.pumpWidget(app);

    const Map<Type, int> typesByNumberOfWidgets = {
      TextFormField: 2,
      FlatButton: 2,
      RaisedButton: 1,
    };

    typesByNumberOfWidgets.forEach((Type type, int numberOfWidgets) {
      expect(find.byType(type), findsNWidgets(numberOfWidgets));
    });
  });

  testWidgets('Finds an email and a password fields', (tester) async {
    await tester.pumpWidget(app);

    const List<Key> fieldsKeys = [
      Key('email_field'),
      Key('password_field'),
    ];

    checkEachKeyOneWidget(fieldsKeys);
  });

  testWidgets('Finds a forgot password, a sign up and a login buttons',
      (tester) async {
    await tester.pumpWidget(app);

    const List<Key> buttonsKeys = [
      Key('forgot_password_button'),
      Key('signin_button'),
      Key('login_button'),
    ];

    checkEachKeyOneWidget(buttonsKeys);
  });

  testWidgets(
      'Checks if the password visibility switches from obscured to visible '
      'and vice-versa', (tester) async {
    await tester.pumpWidget(app);

    const Key visibilityIconKey = Key('password_is_visible_icon');
    const Key nonVisibilityIconKey = Key('password_is_not_visible_icon');

    await tester.tap(find.byKey(visibilityIconKey));
    await tester.pump();

    expect(find.byKey(visibilityIconKey), findsNothing);
    expect(find.byKey(nonVisibilityIconKey), findsOneWidget);

    await tester.tap(find.byKey(nonVisibilityIconKey));
    await tester.pump();

    expect(find.byKey(nonVisibilityIconKey), findsNothing);
    expect(find.byKey(visibilityIconKey), findsOneWidget);
  });
}
