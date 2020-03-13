import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/authentication/validator.dart';

void main() {
  group('Email Validation', () {
    test('Tests different benchmarked emails', () {
      final Map<String, String> emailByCorrectValidationResultMsg = {
        '': AuthenticationMsgs.emptyEmail,
        'johndoe@gmail.com': null,
        '.wooly@example.com': AuthenticationMsgs.invalidEmail,
        'wo..oly@example.com': AuthenticationMsgs.invalidEmail,
        'a@p.com': null,
        'invalid:email@examp': AuthenticationMsgs.invalidEmail,
      };

      emailByCorrectValidationResultMsg
          .forEach((String email, String correctValidationResultMsg) {
        final String emailValidationResultMsg =
            AuthenticationValidator.validateEmail(email);

        expect(emailValidationResultMsg, correctValidationResultMsg);
      });
    });
  });

  group('Password Validation', () {
    test('Password length is smaller than 6', () {
      final Map<String, String> passwordByCorrectValidationResultMsg = {
        '': AuthenticationMsgs.emptyPassword,
        'asdf': AuthenticationMsgs.passwordTooShort,
      };

      passwordByCorrectValidationResultMsg
          .forEach((String password, String correctValidationResultMsg) {
        final String passwordValidationResultMsg =
            AuthenticationValidator.validatePassword(password);

        expect(passwordValidationResultMsg, correctValidationResultMsg);
      });
    });
  });

  group('Confirm Password Validation', () {
    test('Results in error when password and confirm password are different',
        () {
      final String confirmPasswordValidationResult =
          AuthenticationValidator.validateConfirmPassword(
              'asdfasdf', 'asdfasdfg');

      expect(confirmPasswordValidationResult,
          AuthenticationMsgs.confirmPasswordDoesNotMatch);
    });
  });
}
