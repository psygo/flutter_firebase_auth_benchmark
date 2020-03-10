import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_benchmark/widgets/utils/null_widget.dart';
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

  group('Changing the Login Screen to Password Reset', () {
    testWidgets(
      'Clicking the *Forgot* Button '
      '"deletes" the password field in an animation',
        (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

      await tester.tap(find.byKey(Key('forgot_password_button')));
      await tester.pump(Duration(seconds: 2));

      final List<Widget> widgets = WidgetExtractor.extractWidgetsFromStackByKey(tester, Key('password_animation_stack'));

      expect(widgets.length, 2);
      expect(widgets.first.key, Key('password_field'));
      expect(widgets.last.key, Key('password_reset_msg'));
    });

    testWidgets(
      'Clicking the *Forgot* Button '
      '"deletes" the *Forgot*, *Sign Up* and *Login* buttons',
        (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

      await tester.tap(find.byKey(Key('forgot_password_button')));
      await tester.pump();

      final List<Key> shouldNotExistButtonsKeys = [
        Key('forgot_password_button'),
        Key('signup_button'),
        Key('login_button'),
      ];

      shouldNotExistButtonsKeys.forEach((Key key){
        expect(find.byKey(key), findsNothing);
      });
    });

    testWidgets(
      'Checks if the Back Button and the *Send Reset Email* '
      'for when in Password Reset Mode exist', (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

      await tester.tap(find.byKey(Key('forgot_password_button')));
      await tester.pump();

      expect(find.byKey(Key('cancel_reset_button')), findsOneWidget);
      expect(find.byKey(Key('send_password_verification_button')), findsOneWidget);
    });
  });

  group('Changing the Login Screen to Sign Up', (){
    testWidgets(
      'Clicking the *Sign Up* Button '
      '"deletes" the *Forgot*, *Sign Up* and *Login* buttons',
        (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

      await tester.tap(find.byKey(Key('signup_button')));
      await tester.pump();

      final List<Key> shouldNotExistButtonsKeys = [
        Key('forgot_password_button'),
        Key('signup_button'),
        Key('login_button'),
      ];

      shouldNotExistButtonsKeys.forEach((Key key){
        expect(find.byKey(key), findsNothing);
      });
    });

    testWidgets('Checks if the Back Button and Create Account exist', (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

      await tester.tap(find.byKey(Key('signup_button')));
      await tester.pump();

      final List<Key>  signUpButtonsKeys = [
        Key('cancel_signup_button'),
        Key('create_account_button'),
      ];

      signUpButtonsKeys.forEach((Key key){
        expect(find.byKey(key), findsOneWidget);
      });
    });
  });
}
