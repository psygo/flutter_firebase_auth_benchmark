import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/widgets/login/auth_textformfield.dart';

void main() {

  group('Email Field Use Case', (){
    testWidgets(
        'Checks that there is no visibility icon '
        'if `obscureText` is `false`', (tester) async {
      final AuthTextFormField authFieldDummy = AuthTextFormField(
        key: Key('email_field'),
        keyboardType: TextInputType.emailAddress,
        hintText: 'email',
        labelText: 'email',
        icon: Icons.account_circle,
      );

      final MaterialApp wrappedWidget = MaterialApp(
          home: Material(
        child: authFieldDummy,
      ));

      await tester.pumpWidget(wrappedWidget);

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
    
  });
}
