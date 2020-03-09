import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/widgets/login/auth_textformfield.dart';

import 'utils.dart';

void main() {
  group('Email Field Use Case', () {
    final AuthTextFormField authFieldDummy = AuthTextFormField(
      key: Key('email_field'),
      keyboardType: TextInputType.emailAddress,
      hintText: 'email',
      labelText: 'email',
      icon: Icons.account_circle,
    );
    final MaterialApp wrappedAuthField =
        WidgetWrappers.materialWrapper(authFieldDummy);

    testWidgets(
        'Checks that there is no visibility icon '
        'if `obscureText` is `false`', (tester) async {
      await tester.pumpWidget(wrappedAuthField);

      final AuthTextFormFieldState extractedAuthFieldState =
          WidgetExtractor.extractState(tester, AuthTextFormField);

      expect(extractedAuthFieldState.textIsVisible, isTrue);
      expect(find.byType(IconData), findsNothing);
    });
  });

  group('Password Field Use Case', () {
    final AuthTextFormField authFieldDummy = AuthTextFormField(
      key: Key('password_field'),
      keyboardType: TextInputType.visiblePassword,
      hintText: 'password',
      labelText: 'password',
      icon: Icons.lock,
      obscureText: true,
    );
    final MaterialApp wrappedAuthField =
        WidgetWrappers.materialWrapper(authFieldDummy);

    testWidgets(
        'Checks that there is a visibility icon available '
        'when `obscureText` is `true`', (tester) async {
      await tester.pumpWidget(wrappedAuthField);

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('Checks if pressing the `IconButton` switches icons',
        (tester) async {
      await tester.pumpWidget(wrappedAuthField);

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsNothing);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off), findsNothing);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('Checks if the password is obscured (`obscureText`)',
        (tester) async {
      await tester.pumpWidget(wrappedAuthField);

      const String dummyPassword = 'asdf';

      await tester.enterText(find.byType(AuthTextFormField), dummyPassword);
      await tester.pump();

      final String typedPassword =
          RenderUtils.findRenderEditable(tester).text.text;
      final int textLength = dummyPassword.length;
      const String bulletCharacter = '\u{2022}';
      final String obscuredPassword = bulletCharacter * textLength;

      expect(typedPassword, obscuredPassword);
    });

    testWidgets('Chekcs if clicking on the visibility icon shows the password',
        (tester) async {
      await tester.pumpWidget(wrappedAuthField);

      const String dummyPassword = 'asdf';

      await tester.enterText(find.byType(AuthTextFormField), dummyPassword);
      await tester.pump();

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      final String visiblePassword =
          RenderUtils.findRenderEditable(tester).text.text;

      expect(visiblePassword, dummyPassword);
    });
  });
}
