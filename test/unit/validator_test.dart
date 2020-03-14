import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/authentication/validator.dart';

void main() {
  group('Email Validation', () {
    test('Tests different benchmarked emails', () {
      const Map<String, String> emailByCorrectValidationResultMsg = {
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
    test('Tests for different benchmarked passwords', () {
      const Map<String, String> passwordByCorrectValidationResultMsg = {
        '': AuthenticationMsgs.emptyPassword,
        'asdf': AuthenticationMsgs.atLeast8CharMsg,
        'asdfasdf': AuthenticationMsgs.atLeastOneNumberMsg,
        'asdfasd1': AuthenticationMsgs.atLeastOneUpperCaseMsg,
        'asdfasD1': AuthenticationMsgs.atLeastOneSpecialCharacter,
        'ASDFA\$D1': AuthenticationMsgs.atLeastOneLowerCase,
        'asdfa\$D1': null,
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
    test(
        'Checks if passwords are equal, '
        'regardless of internal pre-requisites for the passwords', () {
      const Map<List<String>, String> passwordsByCorrectValidationResultMsg = {
        ['asdfasdf', 'asdfasdfg']:
            AuthenticationMsgs.confirmPasswordDoesNotMatch,
        ['asdfasdf', 'asdfasdf']: null,
      };

      passwordsByCorrectValidationResultMsg.forEach(
          (List<String> passwordAndConfirmPassword,
              String correctValidationResultMsg) {
        final String confirmPassowrdValidationResult =
            AuthenticationValidator.validateConfirmPassword(
                passwordAndConfirmPassword.first,
                passwordAndConfirmPassword.last);

        expect(confirmPassowrdValidationResult, correctValidationResultMsg);
      });
    });
  });
}
