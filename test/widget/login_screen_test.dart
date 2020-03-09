import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/screens/login_screen.dart';

import 'utils.dart';

void main() {
  group('Login Screen Components Check', () {
    final LoginScreen loginScreen = LoginScreen();
    final MaterialApp wrappedLoginScreen =
        WidgetWrappers.materialWrapper(loginScreen);

    void checkEachKeyOneWidget(List<Key> keys) {
      for (final Key key in keys) {
        expect(find.byKey(key), findsOneWidget);
      }
    }

    testWidgets('Finds the fields and buttons on the login screen',
        (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

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
      await tester.pumpWidget(wrappedLoginScreen);

      const List<Key> fieldsKeys = [
        Key('email_field'),
        Key('password_field'),
      ];

      checkEachKeyOneWidget(fieldsKeys);
    });

    testWidgets('Finds a forgot password, a sign up and a login buttons',
        (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

      const List<Key> buttonsKeys = [
        Key('forgot_password_button'),
        Key('signup_button'),
        Key('login_button'),
      ];

      checkEachKeyOneWidget(buttonsKeys);
    });
  });

  group('Extra Initialization Checks', () {
    testWidgets('Checks if the Login Screen has been correctly initialized',
        (tester) async {
      final LoginScreen loginScreen = LoginScreen.defaultLoginScreen;
      final MaterialApp wrappedScreen =
          WidgetWrappers.materialWrapper(LoginScreen.defaultLoginScreen);

      await tester.pumpWidget(wrappedScreen);

      final LoginScreen extractedLoginScreen =
          WidgetExtractor.extractStatelessWidget(tester, LoginScreen);

      expect(loginScreen, equals(extractedLoginScreen));
    });
  });
}
