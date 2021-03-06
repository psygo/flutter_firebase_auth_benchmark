import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:flutter_firebase_auth_benchmark/screens/login_screen.dart';
import 'package:flutter_firebase_auth_benchmark/widgets/login/auth_textformfield.dart';
import 'package:flutter_firebase_auth_benchmark/widgets/utils/text_form_field_without_errortext.dart';

import 'utils.dart';

void main() {
  final LoginScreen loginScreen = LoginScreen();
  final MultiProvider wrappedLoginScreen =
      WidgetWrappers.materialWrapperWithLoginWorkflowProviderAndAuth(
          loginScreen);

  group('Login Screen Login Check', () {
    void checkEachKeyOneWidget(List<Key> keys) {
      for (final Key key in keys) {
        expect(find.byKey(key), findsOneWidget);
      }
    }

    testWidgets('Finds the fields and buttons on the login screen',
        (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

      const Map<Type, int> typesByNumberOfWidgets = {
        TextFormFieldWithErrorTextOption: 2,
        FlatButton: 4,
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

    testWidgets('Finds the Google and Facebook sign in buttons',
        (tester) async {
      await tester.pumpWidget(wrappedLoginScreen);

      const List<Key> buttonsKeys = [
        Key('google_signin_button'),
        Key('facebook_signin_button'),
      ];

      checkEachKeyOneWidget(buttonsKeys);
    });
  });

  group('Changing the Login Screen to Password Reset', () {
    Future<void> setUpResetScenario(WidgetTester tester) async {
      await tester.pumpWidget(wrappedLoginScreen);
      await tester.tap(find.byKey(Key('forgot_password_button')));
      await tester.pump(Duration(seconds: 2));
    }

    testWidgets(
        'Clicking the *Forgot* Button '
        'places the forgot password workflow on top of the stack',
        (tester) async {
      await setUpResetScenario(tester);

      final List<Element> elements =
          WidgetExtractor.extractElementsFromStackByKey(
              tester, Key('login_workflow_stack'));

      Widget bottomOfStack;
      elements.first.visitChildren((Element childElement) {
        bottomOfStack = childElement.widget;
      });

      Widget topOfStack;
      elements.last.visitChildren((Element childElement) {
        childElement.visitChildren((Element childElement) {
          topOfStack = childElement.widget;
        });
      });

      expect(elements.length, 2);
      expect(bottomOfStack.key, Key('login_workflow'));
      expect(topOfStack.key, Key('password_reset_workflow'));
    });

    testWidgets(
        'Checks if the Back Button and the *Send Reset Email* '
        'for when in Password Reset Mode exist', (tester) async {
      await setUpResetScenario(tester);

      final List<Key> signUpButtonKeys = [
        Key('cancel_reset_button'),
        Key('send_password_reset_button')
      ];

      signUpButtonKeys.forEach((Key key) {
        expect(find.byKey(key), findsOneWidget);
      });
    });
  });

  group('Changing the Login Screen to Sign Up', () {
    Future<void> setUpSignUpScenario(WidgetTester tester) async {
      await tester.pumpWidget(wrappedLoginScreen);
      await tester.tap(find.byKey(Key('signup_button')));
      await tester.pump(Duration(seconds: 2));
    }

    testWidgets(
        'Clicking the *Sign Up* Button '
        'places the sign up workflow on top of the stack', (tester) async {
      await setUpSignUpScenario(tester);

      final List<Element> elements =
          WidgetExtractor.extractElementsFromStackByKey(
              tester, Key('login_workflow_stack'));

      Widget bottomOfStack;
      elements.first.visitChildren((Element childElement) {
        bottomOfStack = childElement.widget;
      });

      Widget topOfStack;
      elements.last.visitChildren((Element childElement) {
        childElement.visitChildren((Element childElement) {
          topOfStack = childElement.widget;
        });
      });

      expect(elements.length, 2);
      expect(bottomOfStack.key, Key('login_workflow'));
      expect(topOfStack.key, Key('signup_workflow'));
    });

    testWidgets(
        'Checks if the Back and Create Account buttons exist. '
        'Also checks if the *confirm password* field exists', (tester) async {
      await setUpSignUpScenario(tester);

      final List<Key> signUpButtonsKeys = [
        Key('cancel_signup_button'),
        Key('create_account_button'),
        Key('confirm_password_field'),
      ];

      signUpButtonsKeys.forEach((Key key) {
        expect(find.byKey(key), findsOneWidget);
      });
    });

    testWidgets('There should be 3 text fields here', (tester) async {
      await setUpSignUpScenario(tester);

      expect(find.byType(AuthTextFormField), findsNWidgets(3));
    });
  });
}
