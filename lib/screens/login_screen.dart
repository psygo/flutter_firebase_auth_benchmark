import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/login/login_container.dart';
import '../widgets/login/authentication_textformfield.dart';

class LoginScreen extends StatelessWidget {
  static const double fieldsSpacings = 10;

  LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              LoginContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AuthenticationTextFormField(
                      key: Key('email_field'),
                      hintText: 'email',
                      labelText: 'email',
                      icon: Icons.account_circle,
                    ),
                    SizedBox(
                      height: fieldsSpacings,
                    ),
                    AuthenticationTextFormField(
                      key: Key('password_field'),
                      hintText: 'password',
                      labelText: 'password',
                      icon: Icons.lock,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
