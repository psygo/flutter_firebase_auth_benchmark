import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // bool driverIsNotNull() => driver != null;

  tearDownAll(() async {
    await driver?.close();
  });

  group('Sign In', () {
    test('Successful Sign In', () async {
      await driver.tap(find.byValueKey('email_field'));
      await driver.enterText('pf@gmail.com');

      await driver.tap(find.byValueKey('password_field'));
      await driver.enterText('asdfA\$D1');

      await driver.tap(find.byValueKey('login_button'));

      expect(await driver.getText(find.byValueKey(('logged_in_text'))),
          'You\'re logged in!');
    });
  });

  group('Password Reset', () {});

  group('Sign Up', () {});
}