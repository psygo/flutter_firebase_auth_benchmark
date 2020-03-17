import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/main.dart';

void main() {
  FirebaseAuthenticationApp app;

  setUp(() {
    app = FirebaseAuthenticationApp();
  });

  group('Sign Up', () {
    testWidgets('Simple sign up', (tester) async {
      await tester.pumpWidget(app);

      await tester.tap(find.byKey(Key('signup_button')));

      const String email = 'pst@gmail.com';
      const String password = 'asdfA\$D1';

      await tester.enterText(find.byKey(Key('email_field')), email);
      await tester.enterText(find.byKey(Key('password_field')), password);
      await tester.enterText(
          find.byKey(Key('confirm_password_field')), password);

      await tester.tap(find.byKey(Key('create_account_button')));

      expect(find.text('pst@gmail.com'), findsOneWidget);
    });

    tearDown(() {});
  });
}
