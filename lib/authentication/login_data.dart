import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

class LoginData {
  final String email;
  final String password;

  const LoginData({
    @required this.email,
    @required this.password,
  });

  @override
  String toString() => '$runtimeType($email, $password)';

  @override
  bool operator ==(Object otherObject) =>
      otherObject is LoginData &&
      (email == otherObject.email && password == otherObject.password);

  @override
  int get hashCode => hash2(email, password);
}
