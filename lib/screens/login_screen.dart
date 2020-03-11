import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_benchmark/widgets/login/password_reset_workflow.dart';
import 'package:flutter_firebase_auth_benchmark/widgets/login/signup_workflow.dart';

import '../widgets/login/login_workflow.dart';
import '../widgets/login/password_field_reset_msg_animated_switcher.dart';
import '../exceptions/login.dart';
import '../theme/auxiliary_theming.dart';
import '../theme/colors.dart';
import '../widgets/login/login_container.dart';
import '../widgets/login/auth_textformfield.dart';
import '../widgets/login/button_alignment_wrapper.dart';

enum LoginSubWorkflow {
  login,
  passwordReset,
  signup,
}

class LoginScreen extends StatefulWidget {
  static const double widgetSpacing = 10;

  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final AuthTextFormField _confirmPasswordField = AuthTextFormField(
    key: Key('confirm_password_field'),
    keyboardType: TextInputType.visiblePassword,
    hintText: 'confirm your password',
    hintTextOnFocus: 'your password again',
    labelText: 'confirm password',
    icon: Icons.lock,
    obscureText: true,
  );

  LoginSubWorkflow _loginSubWorkflow;
  PasswordOrMsg _passwordFieldOrResetMsg;

  bool get _isLoginWorkFlow => _loginSubWorkflow == LoginSubWorkflow.login;
  bool get _isResetWorkflow =>
      _loginSubWorkflow == LoginSubWorkflow.passwordReset;
  bool get _isSignUpWorkflow => _loginSubWorkflow == LoginSubWorkflow.signup;
  bool get _isLoginOrResetWorkFlow =>
    _loginSubWorkflow == LoginSubWorkflow.login || _loginSubWorkflow == LoginSubWorkflow.passwordReset;

  @override
  void initState() {
    super.initState();
    _loginSubWorkflow = LoginSubWorkflow.login;
    _passwordFieldOrResetMsg = PasswordOrMsg.password;
  }

  void _switchWorkFlow(LoginSubWorkflow loginSubWorkflow) {
    switch (loginSubWorkflow) {
      case LoginSubWorkflow.login:
        setState(() {
          _passwordFieldOrResetMsg = PasswordOrMsg.password;
          _loginSubWorkflow = LoginSubWorkflow.login;
        });
        break;
      case LoginSubWorkflow.passwordReset:
        setState(() {
          _passwordFieldOrResetMsg = PasswordOrMsg.msg;
          _loginSubWorkflow = LoginSubWorkflow.passwordReset;
        });
        break;
      case LoginSubWorkflow.signup:
        setState(() {
          _loginSubWorkflow = LoginSubWorkflow.signup;
        });
        break;
      default:
        throw InvalidLoginWorkFlowException('This workflow should not exist.');
    }
  }

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
                        height: LoginScreen.widgetSpacing,
                      ),
                      LoginWorkFlow(),
                      SignupWorkflow(),
                      PasswordResetWorkflow(),
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

