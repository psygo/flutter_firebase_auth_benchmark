import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/widgets/login/auth_textformfield.dart';

import 'utils.dart';

void main() {
  MaterialApp materialWrapper(Widget widget) =>
      MaterialApp(home: Material(child: widget));

  group('Email Field Use Case', () {
    final AuthTextFormField authFieldDummy = AuthTextFormField(
      key: Key('email_field'),
      keyboardType: TextInputType.emailAddress,
      hintText: 'email',
      labelText: 'email',
      icon: Icons.account_circle,
    );
    final MaterialApp wrappedAuthField = materialWrapper(authFieldDummy);

    testWidgets(
        'Checks that there is no visibility icon '
        'if `obscureText` is `false`', (tester) async {
      await tester.pumpWidget(wrappedAuthField);

      final AuthTextFormFieldState extractedAuthFieldState =
          extractState(tester, AuthTextFormField);

      expect(extractedAuthFieldState.widget, equals(authFieldDummy));
      expect(extractedAuthFieldState.doNotObscureText, isTrue);
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
    final MaterialApp wrappedAuthField = materialWrapper(authFieldDummy);

    testWidgets(
        'Checks that there is a visibility icon available '
        'when `obscureText` is `true`', (tester) async {
      await tester.pumpWidget(wrappedAuthField);

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('Checks if pressing the `IconButton` switches icons', (tester) async{
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

    testWidgets(
      'Checks if clicking on the icons '
      'switches visibility (`obscureText`)', (tester) async {
        await tester.pumpWidget(wrappedAuthField);

        String dummyPassword = 'asdf';

        await tester.enterText(find.byType(AuthTextFormField), dummyPassword);
        await tester.pump();

        String typedPassword = findRenderEditable(tester).text.text;
        int textLength = dummyPassword.length;
        String bulletCharacter = '\u{2022}';
        String obscuredPassword = bulletCharacter * textLength;
        
        expect(typedPassword, obscuredPassword);

        await tester.tap(find.byIcon(Icons.visibility));
        await tester.pump();

        String visiblePassword = findRenderEditable(tester).text.text;

        expect(visiblePassword, dummyPassword);
    });
  });
}
