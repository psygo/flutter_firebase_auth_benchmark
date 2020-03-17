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

      expect(await driver.getText(find.byValueKey('user_email_text')),
          dummyEmail);
    });
  });

  group('Sign In', () {
    test('Successful Sign In', () async {
      await driver.tap(find.byValueKey('email_field'));
      await driver.enterText('pf@gmail.com');

      await driver.tap(find.byValueKey('password_field'));
      await driver.enterText('asdfA\$D1');

      await driver.tap(find.byValueKey('login_button'));

      await 

      expect(await driver.getText(find.byValueKey('logged_in_text')),
          'You\'re logged in!');
    });
  });

  group('Password Reset', () {});
}
