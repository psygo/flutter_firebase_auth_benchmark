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
  final Widget _passwordResetMsg = SizedBox(
    key: Key('password_reset_msg'),
    height: AuxiliaryTheming.textFieldHeight,
    child: Center(
      child: Text(
        'Please type your recovery email.',
      ),
    ),
  );

  final AuthTextFormField _passwordField = AuthTextFormField(
    key: Key('password_field'),
    keyboardType: TextInputType.visiblePassword,
    hintText: 'password',
    hintTextOnFocus: 'your password',
    labelText: 'password',
    icon: Icons.lock,
    obscureText: true,
  );

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
  Widget _animatedPasswordField;

  bool get _isLoginWorkFlow => _loginSubWorkflow == LoginSubWorkflow.login;
  bool get _isResetWorkflow =>
      _loginSubWorkflow == LoginSubWorkflow.passwordReset;
  bool get _isSignUpWorkflow => _loginSubWorkflow == LoginSubWorkflow.signUp;

  @override
  void initState() {
    super.initState();
    _loginSubWorkflow = LoginSubWorkflow.login;
    _animatedPasswordField = _passwordField;
  }

  void _switchWorkFlow(LoginSubWorkflow loginSubWorkflow) {
    switch (loginSubWorkflow) {
      case LoginSubWorkflow.login:
        setState((){
          _animatedPasswordField = _passwordField;
          _loginSubWorkflow = LoginSubWorkflow.login;
        });
        break;
      case LoginSubWorkflow.passwordReset:
        setState((){
          _animatedPasswordField = _passwordResetMsg;
          _loginSubWorkflow = LoginSubWorkflow.passwordReset;
        });
        break;
      case LoginSubWorkflow.signUp:
        setState(() {
          _loginSubWorkflow = LoginSubWorkflow.signUp;
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
                        height: LoginScreen.fieldsSpacing,
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 1500),
                        switchInCurve: Curves.elasticOut,
                        switchOutCurve: Curves.easeInOutCirc,
                        child: _animatedPasswordField,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          final Animation<Offset> offsetAnimation =
                            Tween<Offset>(
                              begin: Offset(5, 0), 
                              end: Offset.zero).animate(animation);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        layoutBuilder: (Widget currentChild, List<Widget> previousChildren){
                          return Stack(
                            key: Key('password_animation_stack'),
                            children: <Widget>[
                              ...previousChildren,
                              if (currentChild != null) currentChild,
                            ],
                            alignment: Alignment.center,
                          );
                        },
                      ),
                      SizedBox(
                        height: LoginScreen.fieldsButtonsSpacing,
                      ),
                      Visibility(
                        visible: _isLoginWorkFlow,
                        child: ButtonAlignmentWrapper(
                          height: 30,
                          child: FlatButton(
                            key: Key('forgot_password_button'),
                            onPressed: () =>
                              _switchWorkFlow(LoginSubWorkflow.passwordReset),
                            child: Text(
                              'Forgot, huh?',
                              style: TextStyle(
                                color: BasicColors.grey600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: LoginScreen.buttonsSpacing,
                      ),
                      Visibility(
                        visible: _isLoginWorkFlow,
                        child: ButtonAlignmentWrapper(
                          height: 30,
                          child: FlatButton(
                            key: Key('signup_button'),
                            onPressed: () => _switchWorkFlow(LoginSubWorkflow.signUp),
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: BasicColors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: LoginScreen.buttonsSpacing,
                      ),
                      Visibility(
                        visible: _isLoginWorkFlow,
                        child: ButtonAlignmentWrapper(
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
                      ),
                      Visibility(
                        visible: _isResetWorkflow,
                        child: ButtonAlignmentWrapper(
                          height: 30,
                          child: FlatButton(
                            key: Key('cancel_reset_button'),
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
                      Visibility(
                        visible: _isResetWorkflow,
                        child: ButtonAlignmentWrapper(
                          height: 40, 
                          child: SizedBox(
                            width: 165,
                            child: RaisedButton(
                              key: Key('send_password_verification_button'),
                              elevation: AuxiliaryTheming.raisedButtonElevation,
                              color: BasicColors.blue,
                              textColor: BasicColors.white,
                              onPressed: () {},
                              child: Text(
                                'SEND RESET EMAIL',
                                style: TextStyle(
                                  fontSize: 14.5,
                                ),
                              ),
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
