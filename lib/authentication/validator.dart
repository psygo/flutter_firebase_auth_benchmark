abstract class AuthenticationValidator {
  static String validateEmail(String email) {
    if (email.isEmpty) {
      return AuthenticationMsgs.emptyEmail;
    } else if (AuthenticationUtils.emailRegExp.hasMatch(email)) {
      return null;
    } else {
      return AuthenticationMsgs.invalidEmail;
    }
  }

  static String validatePassword(String password) {
    if (password.isEmpty) {
      return AuthenticationMsgs.emptyPassword;
    } else if (AuthenticationUtils.passwordIsTooShort(password)) {
      return AuthenticationMsgs.passwordTooShort;
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
  static const String emptyEmail = 'Your email cannot be blank.';
  static const String invalidEmail = 'Your email is invalid.';

  static const String emptyPassword = 'Your password cannot be blank.';
  static const String passwordTooShort =
      'Your password must be longer than 6 characters.';

  static const String confirmPasswordDoesNotMatch =
      'Your password and your confirmation password don\'t match.';
}

abstract class AuthenticationUtils {
  static final RegExp emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool passwordIsTooShort(String password) => password.length < 6;
}
