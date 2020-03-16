import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

class LoginData {
  final String name;
  final String password;

  LoginData({
    @required this.name,
    @required this.password,
  });

  @override
  String toString() => '$runtimeType($name, $password)';

  bool operator ==(Object otherObject) => otherObject is LoginData
      ? name == otherObject.name && password == otherObject.password
      : false;

  int get hashCode => hash2(name, password);
}
