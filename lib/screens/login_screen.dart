import 'package:flutter/material.dart';

import '../theme/auxiliary_theming.dart';
import '../theme/colors.dart';
import '../widgets/login/login_container.dart';
import '../widgets/login/auth_textformfield.dart';

enum LoginSubWorkflow {
  login,
  passwordReset,
  signUp,
}

class LoginScreen extends StatefulWidget {
  static const double fieldsSpacing = 10;
  static const double fieldsButtonsSpacing = 10;
  static const double buttonsSpacing = 10;

  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: BasicColors.blue,
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
                        hintTextOnFocus: 'your email',
                        labelText: 'email',
                        icon: Icons.account_circle,
                      ),
                      SizedBox(
                        height: LoginScreen.fieldsSpacing,
                      ),
                      AuthTextFormField(
                        key: Key('password_field'),
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'password',
                        hintTextOnFocus: 'your password',
                        labelText: 'password',
                        icon: Icons.lock,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: LoginScreen.fieldsButtonsSpacing,
                      ),
                      ButtonAlignmentWrapper(
                        height: 30,
                        child: FlatButton(
                          key: Key('forgot_password_button'),
                          onPressed: () {},
                          child: Text(
                            'Forgot, huh?',
                            style: TextStyle(color: BasicColors.grey600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: LoginScreen.buttonsSpacing,
                      ),
                      ButtonAlignmentWrapper(
                        height: 30,
                        child: FlatButton(
                          key: Key('signup_button'),
                          onPressed: () {},
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: BasicColors.blue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: LoginScreen.buttonsSpacing,
                      ),
                      ButtonAlignmentWrapper(
                        height: 40,
                        child: RaisedButton(
                          key: Key('login_button'),
                          elevation: AuxiliaryTheming.raisedButtonElevation,
                          color: BasicColors.blue,
                          textColor: BasicColors.white,
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
