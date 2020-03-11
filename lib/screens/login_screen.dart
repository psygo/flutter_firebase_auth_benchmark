import 'package:flutter/material.dart';

import '../exceptions/animations.dart';
import '../exceptions/login.dart';
import '../theme/auxiliary_theming.dart';
import '../theme/colors.dart';
import '../widgets/login/login_container.dart';
import '../widgets/login/auth_textformfield.dart';
import '../widgets/login/button_alignment_wrapper.dart';

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
  bool get _isLoginOrSignUpWorkflow => 
    _loginSubWorkflow == LoginSubWorkflow.login || _loginSubWorkflow == LoginSubWorkflow.signUp;
  bool get _isLoginOrResetWorkFlow =>
    _loginSubWorkflow == LoginSubWorkflow.login || _loginSubWorkflow == LoginSubWorkflow.passwordReset;

  @override
  void initState() {
    super.initState();
    _loginSubWorkflow = LoginSubWorkflow.login;
    _animatedPasswordField = _passwordField;
  }

  void _switchWorkFlow(LoginSubWorkflow loginSubWorkflow) {
    switch (loginSubWorkflow) {
      case LoginSubWorkflow.login:
        setState(() {
          _animatedPasswordField = _passwordField;
          _loginSubWorkflow = LoginSubWorkflow.login;
        });
        break;
      case LoginSubWorkflow.passwordReset:
        setState(() {
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
                      Visibility(
                        visible: _isLoginOrSignUpWorkflow,
                        child: SizedBox(
                          height: LoginScreen.fieldsSpacing,
                        ),
                      ),
                      Visibility(
                        visible: _isResetWorkflow,
                        child: SizedBox(
                          height: LoginScreen.fieldsButtonsSpacing,
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 1500),
                        switchInCurve: Curves.bounceOut,
                        switchOutCurve: Curves.easeInExpo,
                        child: _animatedPasswordField,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          final Animation<Offset> outOffsetAnimation =
                              Tween<Offset>(
                                begin: Offset(1, 0), 
                                end: Offset.zero
                              ).animate(animation);

                          final Animation<Offset> inOffsetAnimation =
                              Tween<Offset>(
                                begin: Offset(-1, 0), 
                                end: Offset.zero
                              ).animate(animation);

                          final Animation<double> inFadeAnimation =
                              Tween<double>(
                                begin: 0,
                                end: 1
                              ).animate(animation);

                          if (child.key == Key('password_reset_msg')){
                            // return ClipRect(
                            //   child: SlideTransition(
                            //     position: inOffsetAnimation,
                            //     child: child,
                            //   ),
                            // );

                            return ClipRect(
                              child: FadeTransition(
                                opacity: inFadeAnimation,
                                child: child,
                              )
                            );
                          }
                          else if (child.key == Key('password_field')){
                            return ClipRect(
                              child: SlideTransition(
                                position: outOffsetAnimation,
                                child: child,
                              ),
                            );
                          }
                          else {
                            throw InvalidAnimationAttempt('There should be only 2 animation cases.');
                          }
                        },
                        layoutBuilder: (Widget currentChild,
                            List<Widget> previousChildren) {
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
                      Visibility(
                        visible: _isLoginOrResetWorkFlow,
                        child: SizedBox(
                          height: LoginScreen.fieldsButtonsSpacing,
                        ),
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
                      Visibility(
                        visible: _isLoginWorkFlow,
                        child: SizedBox(
                          height: LoginScreen.buttonsSpacing,
                        ),
                      ),
                      Visibility(
                        visible: _isLoginWorkFlow,
                        child: ButtonAlignmentWrapper(
                          height: 30,
                          child: FlatButton(
                            key: Key('signup_button'),
                            onPressed: () =>
                                _switchWorkFlow(LoginSubWorkflow.signUp),
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: BasicColors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isLoginWorkFlow,
                        child: SizedBox(
                          height: LoginScreen.buttonsSpacing,
                        ),
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
                            onPressed: () =>
                              _switchWorkFlow(LoginSubWorkflow.login),
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
                        child: SizedBox(
                          height: LoginScreen.buttonsSpacing,
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
                      Visibility(
                        visible: _isSignUpWorkflow,
                        child: SizedBox(
                          height: LoginScreen.fieldsSpacing,
                        ),
                      ),
                      Visibility(
                        visible: _isSignUpWorkflow,
                        child: _confirmPasswordField,
                      ),
                      Visibility(
                        visible: _isSignUpWorkflow,
                        child: SizedBox(
                          height: LoginScreen.fieldsButtonsSpacing,
                        ),
                      ),
                      Visibility(
                        visible: _isSignUpWorkflow,
                        child: ButtonAlignmentWrapper(
                          height: 30,
                          child: FlatButton(
                            key: Key('cancel_signup_button'),
                            onPressed: () =>
                              _switchWorkFlow(LoginSubWorkflow.login),
                            child: Text(
                              'CANCEL SIGN UP',
                              style: TextStyle(
                                color: BasicColors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isSignUpWorkflow,
                        child: SizedBox(
                          height: LoginScreen.buttonsSpacing,
                        ),
                      ),
                      Visibility(
                        visible: _isSignUpWorkflow,
                        child: ButtonAlignmentWrapper(
                          height: 40,
                          child: SizedBox(
                            width: 165,
                            child: RaisedButton(
                              key: Key('create_account_button'),
                              elevation: AuxiliaryTheming.raisedButtonElevation,
                              color: BasicColors.blue,
                              textColor: BasicColors.white,
                              onPressed: () {},
                              child: Text(
                                'CREATE ACCOUNT',
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