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
    if (AuthenticationUtils.passwordIsTooShort(password)) {
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
  static const String confirmPasswordDoesNotMatch =
      'Your password and your confirmation password don\'t match.';
  static const String passwordTooShort =
      'Your password must be longer than 6 characters.';
}

abstract class AuthenticationUtils {
  static final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  static bool passwordIsTooShort(String password) => password.length < 6;
}
