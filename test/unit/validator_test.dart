import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/authentication/validator.dart';

void main() {
  group('Email Validation', () {
    test('Can email validation handle an empty field?', () {
      final String emailValidationResult =
          AuthenticationValidator.validateEmail('');

      expect(emailValidationResult, AuthenticationValidator.emptyEmailMsg);
    });

    test('', () {});
  });

  group('Password Validation', () {
    test('Password length is smaller than 6', () {
      final String passwordValidationResult =
          AuthenticationValidator.validatePassword('asdf');

      expect(passwordValidationResult,
          AuthenticationValidator.passwordTooShortMsg);
    });
  });

  group('Confirm Password Validation', () {
    test('Results in error when password and confirm password are different',
        () {
      final String confirmPasswordValidationResult =
          AuthenticationValidator.validateConfirmPassword(
              'asdfasdf', 'asdfasdfg');

      expect(confirmPasswordValidationResult,
          AuthenticationValidator.confirmPasswordDoesNotMatchMsg);
    });
  });
}
