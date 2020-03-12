abstract class AuthenticationValidator {
  static String validateEmail(String email) 
    => email.isNotEmpty ? null : 'Please type your email.';

  static String validatePassword(String password) => null;

  static String validateConfirmPassword(String password, String confirmPassword)
    => password == confirmPassword ? null : 'Your password and your confirmation password don\'t match';
}