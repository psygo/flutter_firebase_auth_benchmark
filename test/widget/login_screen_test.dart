import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/screens/login_screen.dart';

import 'utils.dart';

void main() {
  final LoginScreen loginScreen = LoginScreen();
  final MaterialApp wrappedLoginScreen =
      WidgetWrappers.materialWrapper(loginScreen);

  group('Login Screen Components Check', () {
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

  group('Changing the Login Screen to Password Reset', (){
    testWidgets('Clicking the *Forgot* Button "deletes" the password field', (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

      await tester.tap(find.byKey(Key('forgot_password_button')));
      await tester.pump();

      expect(find.byKey(Key('password_field')), findsNothing);
    });

    testWidgets('Back Button for when in Password Reset Mode', (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

      await tester.tap(find.byKey(Key('forgot_password_button')));
      await tester.pump();

      expect(find.byKey(Key('cancel_reset')), findsOneWidget);
    });
  });
}
