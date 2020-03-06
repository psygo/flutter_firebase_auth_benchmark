import 'package:flutter/material.dart';

import '../widgets/login/login_container.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LoginContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    key: Key('email_field'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    key: Key('password_field'),
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}