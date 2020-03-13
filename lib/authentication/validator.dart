abstract class AuthenticationValidator {
  static String emptyEmailMsg = 'Please type your email.';
  static String confirmPasswordDoesNotMatchMsg = 
    'Your password and your confirmation password don\'t match.';
  static String passwordTooShortMsg = 
    'Your password must be longer than 6 characters.';

  static String validateEmail(String email) 
    => email.isNotEmpty ? null : emptyEmailMsg;

  static String validatePassword(String password){
    if (password.length < 6){
      return passwordTooShortMsg;
    }
    else {
      return null;
    }
  }

  static String validateConfirmPassword(String password, String confirmPassword)
    => password == confirmPassword ? null : confirmPasswordDoesNotMatchMsg;
}