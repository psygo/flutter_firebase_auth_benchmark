import 'package:flutter_driver/flutter_driver.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

void main() {
  const Duration firebaseStandardTimeout = Duration(seconds: 5);

  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    await driver?.close();
  });

  group('Sign Up', () {
    setUpAll(() async => await driver.tap(find.byValueKey('signup_button')));

    tearDownAll(
        () async => await driver.tap(find.byValueKey('cancel_signup_button')));

    Future<void> signUp({
      @required email,
      @required password,
    }) async {
      await driver.tap(find.byValueKey('email_field'));
      await driver.enterText(email);

      await driver.tap(find.byValueKey('password_field'));
      await driver.enterText(password);

      await driver.tap(find.byValueKey('confirm_password_field'));
      await driver.enterText(password);

      await driver.tap(find.byValueKey('create_account_button'));
    }

    test('Successful Sign Up', () async {
      const String dummySignUpEmail = 'ppsf@gmail.com';
      const String dummyPassword = 'asdfA\$D1';

      await signUp(email: dummySignUpEmail, password: dummyPassword);

      expect(await driver.getText(find.byValueKey('user_email_text')),
          dummySignUpEmail);

      await driver.tap(find.byValueKey('delete_account_button'));
    });

    test('Email already in use', () async {
      const String permanentEmail = 'pf@gmail.com';
      const String dummyPassword = 'asdfA\$D1';

      await signUp(email: permanentEmail, password: dummyPassword);

      expect(await driver.getText(find.text('user already exists')),
          'user already exists');
    });
  });

  group('Sign In', () {
    Future<void> signIn({
      @required email,
      @required password,
    }) async {
      await driver.tap(find.byValueKey('email_field'));
      await driver.enterText(email);

      await driver.tap(find.byValueKey('password_field'));
      await driver.enterText(password);

      await driver.tap(find.byValueKey('login_button'));
    }

    test('Successful Sign In', () async {
      const String permanentEmail = 'pf@gmail.com';
      const String dummyPassword = 'asdfA\$D1';

      await signIn(email: permanentEmail, password: dummyPassword);

      expect(await driver.getText(find.byValueKey('logged_in_text')),
          'You\'re logged in!');

      await driver.tap(find.byValueKey('sign_out_button'));
    });

    test('User not found', () async {
      const String fakeUserEmail = 'pf@gmail.co';
      const String dummyPassword = 'asdfA\$D1';

      await signIn(email: fakeUserEmail, password: dummyPassword);

      expect(
          await driver.getText(find.text('user not found'),
              timeout: firebaseStandardTimeout),
          'user not found');
    });

    test('Wrong password', () async {
      const String permanentEmail = 'pf@gmail.com';
      const String wrongPassword = 'asdfA\$D11';

      await signIn(email: permanentEmail, password: wrongPassword);

      expect(
          await driver.getText(find.text('wrong password'),
              timeout: firebaseStandardTimeout),
          'wrong password');
    });
  });

  group('Password Reset', () {
    setUpAll(() async =>
        await driver.tap(find.byValueKey('forgot_password_button')));

    tearDownAll(
        () async => await driver.tap(find.byValueKey('cancel_reset_button')));

    Future<void> resetPassword({@required email}) async {
      await driver.tap(find.byValueKey('email_field'));
      await driver.enterText(email);

      await driver.tap(find.byValueKey('send_password_reset_button'));
    }

    test('Simple password reset', () async {
      const String permanentEmail = 'windbaduk@gmail.com';

      await resetPassword(email: permanentEmail);

      expect(
          await driver.getText(find.text('✓'),
              timeout: firebaseStandardTimeout),
          '✓');
    });

    test('User not found error message', () async {
      const String userNotFoundEmail = 'pf@gmail.co';

      await resetPassword(email: userNotFoundEmail);

      expect(
          await driver.getText(find.text('user not found'),
              timeout: firebaseStandardTimeout),
          'user not found');
    });
  });
}
