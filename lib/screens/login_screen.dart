import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_benchmark/exceptions/login.dart';

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
  LoginSubWorkflow _loginSubWorkflow = LoginSubWorkflow.login;

  bool get _isLoginWorkFlow => _loginSubWorkflow == LoginSubWorkflow.login;
  bool get _isResetWorkflow =>
      _loginSubWorkflow == LoginSubWorkflow.passwordReset;
  bool get _isSignUpWorkflow => _loginSubWorkflow == LoginSubWorkflow.signUp;

  void _switchWorkFlow(LoginSubWorkflow loginSubWorkflow) {
    switch (loginSubWorkflow) {
      case LoginSubWorkflow.login:
        setState(() => _loginSubWorkflow = LoginSubWorkflow.login);
        break;
      case LoginSubWorkflow.passwordReset:
        setState(() => _loginSubWorkflow = LoginSubWorkflow.passwordReset);
        break;
      case LoginSubWorkflow.signUp:
        break;
      default:
        throw InvalidLoginWorkFlowException('This workflow should not exist.');
    }
  }

  // AnimationController controller;
  // Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    // controller =
    //     AnimationController(vsync: this, duration: Duration(seconds: 5));

    // offset = Tween<Offset>(begin: Offset.zero, end: Offset(0, 1))
    //     .animate(controller);
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  Widget _myAnimatedWidget = AuthTextFormField(
    key: Key('password_field'),
    keyboardType: TextInputType.visiblePassword,
    hintText: 'password',
    hintTextOnFocus: 'your password',
    labelText: 'password',
    icon: Icons.lock,
    obscureText: true,
  );

  static const Widget _nullBox = SizedBox.shrink();

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
                        duration: Duration(seconds: 1),
                        child: _myAnimatedWidget,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          final  offsetAnimation =
                            Tween<Offset>(
                              begin: Offset(0, 0), 
                              end: Offset(0, -0.5)).animate(animation);

                          return SlideTransition(
                            child: child,
                            position: offsetAnimation,
                          );
                        },
                      ),
                      // Visibility(
                      //   visible: _isLoginWorkFlow,
                      //   child: AuthTextFormField(
                      //     key: Key('password_field'),
                      //     keyboardType: TextInputType.visiblePassword,
                      //     hintText: 'password',
                      //     hintTextOnFocus: 'your password',
                      //     labelText: 'password',
                      //     icon: Icons.lock,
                      //     obscureText: true,
                      //   ),
                      // ),
                      SizedBox(
                        height: LoginScreen.fieldsButtonsSpacing,
                      ),
                      Visibility(
                        visible: _isResetWorkflow,
                        maintainState: true,
                        child: ButtonAlignmentWrapper(
                          height: 30,
                          child: FlatButton(
                            key: Key('cancel_reset'),
                            onPressed: () {
                              _switchWorkFlow(LoginSubWorkflow.login);
                              setState(() {
                                _myAnimatedWidget = _nullBox;
                              });
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
