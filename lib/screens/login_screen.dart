import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/login/login_container.dart';
import '../widgets/login/authentication_textformfield.dart';

class LoginScreen extends StatelessWidget {
  static const double fieldsSpacing = 10;
  static const double fieldsButtonsSpacing = 10;
  static const double buttonsSpacing = 3;

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
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'email',
                      labelText: 'email',
                      icon: Icons.account_circle,
                    ),
                    SizedBox(
                      height: fieldsSpacing,
                    ),
                    AuthenticationTextFormField(
                      key: Key('password_field'),
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'password',
                      labelText: 'password',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: fieldsButtonsSpacing,
                    ),
                    FlatButton(
                      key: Key('forgot_password_button'),
                      onPressed: () {},
                      child: Text(
                        'Forgot Your Password, huh?',
                        style: TextStyle(color: grey600),
                      ),
                    ),
                    SizedBox(
                      height: buttonsSpacing,
                    ),
                    FlatButton(
                      key: Key('signin_button'),
                      onPressed: () {},
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: buttonsSpacing,
                    ),
                    FlatButton(
                      key: Key('login_button'),
                      color: blue,
                      textColor: white,
                      onPressed: () {},
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
