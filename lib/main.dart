import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() => runApp(FirebaseAuthenticationApp());

class FirebaseAuthenticationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
