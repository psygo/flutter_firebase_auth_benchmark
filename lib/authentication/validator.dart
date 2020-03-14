abstract class AuthenticationValidator {
  static String validateEmail(String email) {
    if (AuthenticationUtils.emailIsEmpty(email)) {
      return AuthenticationMsgs.emptyEmail;
    } else if (AuthenticationUtils.invalidEmail(email)) {
      return AuthenticationMsgs.invalidEmail;
    } else {
      return null;
    }
  }

  static String validatePassword(String password) {
    if (password.isEmpty) {
      return AuthenticationMsgs.emptyPassword;
    } else if (AuthenticationUtils.passwordIsTooShort(password)) {
      return AuthenticationMsgs.atLeast8CharMsg;
    } else if (AuthenticationUtils.passwordHasNoNumber(password)) {
      return AuthenticationMsgs.atLeastOneNumberMsg;
    } else if (AuthenticationUtils.passwordHasNoUpperCase(password)) {
      return AuthenticationMsgs.atLeastOneUpperCaseMsg;
    } else if (AuthenticationUtils.passwordHasNoSpecialChar(password)){
      return AuthenticationMsgs.atLeastOneSpecialCharacter;
    } else if (AuthenticationUtils.passwordHasNoLowerCase(password)){
      return AuthenticationMsgs.atLeastOneLowerCase;
    } else if (AuthenticationUtils.invalidPassword(password)) {
      return AuthenticationMsgs.invalidPassword;
    } else {
      return null;
    }
  }

  static String validateConfirmPassword(
          String password, String confirmPassword) =>
      password == confirmPassword
          ? null
          : AuthenticationMsgs.confirmPasswordDoesNotMatch;
}

abstract class AuthenticationMsgs {
  static const String emptyEmail = 'Can\'t be blank.';
  static const String invalidEmail = 'Invalid email.';

  static const String emptyPassword = 'Can\'t be blank.';
  static const String atLeast8CharMsg = 'Min: 8 characters.';
  static const String atLeastOneNumberMsg = 'Min: 1 number.';
  static const String atLeastOneUpperCaseMsg = 'Min: 1 upper case.';
  static const String atLeastOneSpecialCharacter = 'Min: 1 special char.';
  static const String atLeastOneLowerCase = 'Min: 1 lower case.';
  static const String invalidPassword = 'Invalid Password.';

  static const String confirmPasswordDoesNotMatch =
      'Your password and your confirmation password don\'t match.';
}

abstract class AuthenticationUtils {
  static const passwordMinLength = 8;

  static final RegExp emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static final RegExp completePasswordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$');
  static final RegExp atLeastOneNumberRegExp = RegExp(r'^(?=.*\d)');
  static final RegExp atLeastOneUpperCaseRegExp = RegExp(r'^(?=.*[A-Z])');
  static final RegExp atLeastOneSpecialCharRegExp = RegExp(r'^(?=.*[@$!%*?&#])');
  static final RegExp atLeastOneLowerCaseRegExp = RegExp(r'^(?=.*[a-z])');

  static bool emailIsEmpty(String email) => email.isEmpty;
  static bool invalidEmail(String email) => !emailRegExp.hasMatch(email);

  static bool passwordIsTooShort(String password) => password.length < passwordMinLength;
  static bool passwordHasNoNumber(String password) => 
    !atLeastOneNumberRegExp.hasMatch(password);
  static bool passwordHasNoUpperCase(String password) =>
    !atLeastOneUpperCaseRegExp.hasMatch(password);
  static bool passwordHasNoSpecialChar(String password) =>
    !atLeastOneSpecialCharRegExp.hasMatch(password);
  static bool passwordHasNoLowerCase(String password) => 
    !atLeastOneLowerCaseRegExp.hasMatch(password);
  static bool invalidPassword(String password) => 
    !completePasswordRegExp.hasMatch(password);
}
