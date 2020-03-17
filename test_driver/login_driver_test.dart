import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    await driver?.close();
  });

  group('Sign Up', () {
    const String dummyEmail = 'ppsf@gmail.com';
    const String dummyPassword = 'asdfA\$D1';

    test('Successful Sign Up', () async {
      await driver.tap(find.byValueKey('signup_button'));

      await driver.tap(find.byValueKey('email_field'));
      await driver.enterText(dummyEmail);

      await driver.tap(find.byValueKey('password_field'));
      await driver.enterText(dummyPassword);

      await driver.tap(find.byValueKey('confirm_password_field'));
      await driver.enterText(dummyPassword);

      await driver.tap(find.byValueKey('create_account_button'));

      expect(
          await driver.getText(find.byValueKey('user_email_text')), dummyEmail);

      await driver.tap(find.byValueKey('delete_account_button'));
    });
  });

  group('Sign In', () {
    const String dummyPermanentEmail = 'pf@gmail.com';
    const String dummyPassword = 'asdfA\$D1';

    bool createAccountButtonExists(SerializableFinder createAccountButton) =>
        createAccountButton != null;

    test('Successful Sign In', () async {
      final SerializableFinder createAccountButton =
          find.byValueKey('create_account_button');
      final SerializableFinder cancelSignupButton =
          find.byValueKey('cancel_signup_button');
      if (createAccountButtonExists(createAccountButton)){
        await driver.tap(cancelSignupButton);
      }
      
      await driver.tap(find.byValueKey('email_field'));
      await driver.enterText(dummyPermanentEmail);

      await driver.tap(find.byValueKey('password_field'));
      await driver.enterText(dummyPassword);

      await driver.tap(find.byValueKey('login_button'));

      expect(await driver.getText(find.byValueKey('logged_in_text')),
          'You\'re logged in!');

      await driver.tap(find.byValueKey('sign_out_button'));
    });
  });

  group('Password Reset', () {});
}
