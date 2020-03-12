import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/authentication/validator.dart';

void main(){
  group('Email Validation', (){
    test('Can email validation handle an empty field?', (){
      final String emailValidationResult = AuthenticationValidator
        .validateEmail('');

      expect(emailValidationResult, 'Please type your email.');
    });

    test('', (){

    });
  });

  group('Confirm Password Validation', (){
    test('Results in error when password and confirm password are different', (){
      final String confirmPasswordResult = AuthenticationValidator
        .validateConfirmPassword('asdfasdf', 'asdfasdfg');

      expect(confirmPasswordResult, 'Your password and your confirmation password don\'t match');
    });
  });
}