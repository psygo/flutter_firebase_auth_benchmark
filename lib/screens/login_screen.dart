import 'package:flutter/material.dart';

import '../theme/auxiliary_theming.dart';
import '../theme/colors.dart';
import '../widgets/login/login_container.dart';
import '../widgets/login/auth_textformfield.dart';

class LoginScreen extends StatelessWidget {
  static const double fieldsSpacing = 10;
  static const double fieldsButtonsSpacing = 10;
  static const double buttonsSpacing = 10;

  static final LoginScreen defaultLoginScreen =
      const LoginScreen(key: Key('login_screen'));

  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LoginContainer(
                  child: ListView(
                    children: <Widget>[
                      AuthTextFormField(
                        key: Key('email_field'),
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'email',
                        hintTextOnFocus: '',
                        labelText: 'email',
                        icon: Icons.account_circle,
                      ),
                      SizedBox(
                        height: fieldsSpacing,
                      ),
                      AuthTextFormField(
                        key: Key('password_field'),
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'password',
                        hintTextOnFocus: '',
                        labelText: 'password',
                        icon: Icons.lock,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: fieldsButtonsSpacing,
                      ),
                      ButtonAlignmentWrapper(
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
                      ButtonAlignmentWrapper(
                        height: 30,
                        child: FlatButton(
                          key: Key('signup_button'),
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
                      ButtonAlignmentWrapper(
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
          ],
        ),
      ),
    );
  }
}

class ButtonAlignmentWrapper extends StatelessWidget {
  final double height;
  final Widget child;

  const ButtonAlignmentWrapper({
    Key key,
    @required this.height,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            child,
          ],
        ));
  }
}
