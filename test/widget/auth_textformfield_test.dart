import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/widgets/login/auth_textformfield.dart';

void main() {
  MaterialApp materialWrapper(Widget widget) =>
      MaterialApp(home: Material(child: widget));

  StatefulElement extractStatefulElementByType(
          WidgetTester tester, Type type) =>
      tester.element(find.byType(type));

  St extractStateFromElement<St extends State<StatefulWidget>,
          El extends StatefulElement>(El element) =>
      element.state as St;

  St extractState<St extends State<StatefulWidget>>(WidgetTester tester, Type type) {
    final StatefulElement element = extractStatefulElementByType(tester, type);
    return extractStateFromElement(element);
  }

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

      final AuthTextFormFieldState extractedAuthFieldState =
          extractState(tester, AuthTextFormField);

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });
}
