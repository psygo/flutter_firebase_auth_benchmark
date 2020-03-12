abstract class AuthenticationValidator {
  String validateEmail(String email);
  String validatePassword(String password);
  String validateConfirmPassword(String password, String confirmPassword);
}