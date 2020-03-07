import 'package:flutter/material.dart';

import '../theme/auxiliary_theming.dart';
import '../theme/colors.dart';
import '../widgets/login/login_container.dart';
import '../widgets/login/authentication_textformfield.dart';

class LoginScreen extends StatelessWidget {
  static const double fieldsSpacing = 10;
  static const double fieldsButtonsSpacing = 10;
  static const double buttonsSpacing = 10;

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
                    SizedBox(
                      width: 150,
                      height: 30,
                      child: FlatButton(
                        key: Key('forgot_password_button'),
                        onPressed: () {},
                        child: Text(
                          'Forgot, huh?',
                          style: TextStyle(color: grey600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: buttonsSpacing,
                    ),
                    SizedBox(
                      width: 120,
                      height: 30,
                      child: FlatButton(
                        key: Key('signin_button'),
                        onPressed: () {},
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: buttonsSpacing,
                    ),
                    SizedBox(
                      width: 110,
                      height: 40,
                      child: RaisedButton(
                        key: Key('login_button'),
                        elevation: raisedButtonElevation,
                        color: blue,
                        textColor: white,
                        onPressed: () {},
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 14.5,
                          ),
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
