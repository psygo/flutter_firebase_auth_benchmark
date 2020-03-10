import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_benchmark/exceptions/login.dart';
import 'package:flutter_firebase_auth_benchmark/widgets/utils/null_widget.dart';

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

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  static final NullWidget _nullWidget = NullWidget();

  LoginSubWorkflow _loginSubWorkflow = LoginSubWorkflow.login;

  bool get _isLoginWorkFlow => _loginSubWorkflow == LoginSubWorkflow.login;
  bool get _isResetWorkflow =>
      _loginSubWorkflow == LoginSubWorkflow.passwordReset;
  bool get _isSignUpWorkflow => _loginSubWorkflow == LoginSubWorkflow.signUp;

  void _switchWorkFlow(LoginSubWorkflow loginSubWorkflow) {
    switch (loginSubWorkflow) {
      case LoginSubWorkflow.login:
        setState((){
          _loginSubWorkflow = LoginSubWorkflow.login;
          _animatedPasswordField = _passwordField;
        });
        break;
      case LoginSubWorkflow.passwordReset:
        setState((){
          _animatedPasswordField = _nullWidget;
          _loginSubWorkflow = LoginSubWorkflow.passwordReset;
        });
        break;
      case LoginSubWorkflow.signUp:
        setState(() => _loginSubWorkflow = LoginSubWorkflow.signUp);
        break;
      default:
        throw InvalidLoginWorkFlowException('This workflow should not exist.');
    }
  }

  Widget _animatedPasswordField = _passwordField;

  static const AuthTextFormField _passwordField = AuthTextFormField(
    key: Key('password_field'),
    keyboardType: TextInputType.visiblePassword,
    hintText: 'password',
    hintTextOnFocus: 'your password',
    labelText: 'password',
    icon: Icons.lock,
    obscureText: true,
  );

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
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 1500),
                        switchInCurve: Curves.elasticOut,
                        switchOutCurve: Curves.easeInOutCirc,
                        child: _animatedPasswordField,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          final offsetAnimation =
                            Tween<Offset>(
                              begin: Offset(2, 0), 
                              end: Offset.zero).animate(animation);

                          return SlideTransition(
                            child: child,
                            position: offsetAnimation,
                          );
                        },
                      ),
                      SizedBox(
                        height: LoginScreen.fieldsButtonsSpacing,
                      ),
                      Visibility(
                        visible: _isResetWorkflow,
                        child: ButtonAlignmentWrapper(
                          height: 30,
                          child: FlatButton(
                            key: Key('cancel_reset'),
                            onPressed: () {
                              _switchWorkFlow(LoginSubWorkflow.login);
                            },
                            child: Text(
                              'CANCEL RESET',
                              style: TextStyle(
                                color: BasicColors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ButtonAlignmentWrapper(
                        height: 30,
                        child: FlatButton(
                          key: Key('forgot_password_button'),
                          onPressed: () {
                            _switchWorkFlow(LoginSubWorkflow.passwordReset);
                          },
                          child: Text(
                            'Forgot, huh?',
                            style: TextStyle(
                              color: BasicColors.grey600,
                            ),
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
