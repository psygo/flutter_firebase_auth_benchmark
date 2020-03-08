import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/widgets/login/auth_textformfield.dart';

void main() {
  MaterialApp materialWrapper(Widget widget) => MaterialApp(
      home: Material(
    child: widget,
  ));

  group('Email Field Use Case', (){
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

      final StatefulElement extractedAuthFieldElement =
          tester.element(find.byType(AuthTextFormField));
      final AuthTextFormFieldState extractedAuthFieldState =
          extractedAuthFieldElement.state as AuthTextFormFieldState;

      expect(extractedAuthFieldState.widget, equals(authFieldDummy));
      expect(extractedAuthFieldState.doNotObscureText, isTrue);
      expect(find.byType(IconData), findsNothing);
    });
  });
  
  group('Password Field Use Case', (){
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
        
    });
  });
}
