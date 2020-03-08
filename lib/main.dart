import 'package:flutter/material.dart';

import 'theme/theme.dart';
import 'screens/login_screen.dart';

void main() => runApp(FirebaseAuthenticationApp());

class FirebaseAuthenticationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: LoginScreen.defaultLoginScreen,
    );
  }
}
