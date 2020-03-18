import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/main.dart';

void main() {
  const String dummyEmail = 'ppsf@gmail.com';
  const String dummyPassword = 'asdfA\$D1';
  FirebaseAuthenticationApp app;

  setUp(() {
    app = FirebaseAuthenticationApp();
  });

  group('Sign Up', () {
    testWidgets('Simple sign up', (tester) async {
      await tester.pumpWidget(app);

      await tester.tap(find.byKey(Key('signup_button')));
      await tester.pump();

      await tester.enterText(find.byKey(Key('email_field')), dummyEmail);
      await tester.pump();
      await tester.enterText(find.byKey(Key('password_field')), dummyPassword);
      await tester.pump();
      await tester.enterText(
          find.byKey(Key('confirm_password_field')), dummyPassword);
      await tester.pump();

      await tester.tap(find.byKey(Key('create_account_button')));
      await tester.pump();

      // expect(find.byKey(Key('user_email_text')), findsOneWidget);
      // expect(find.text('ppsf@gmail.com'), findsOneWidget);
      // expect(find.byKey(Key('user_uid_text')), findsOneWidget);
    });

    tearDown(() {});
  });
}
