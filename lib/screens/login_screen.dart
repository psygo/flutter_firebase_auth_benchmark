import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authentication/validator.dart';
import '../providers/login_workflow_provider.dart';
import '../theme/colors.dart';
import '../widgets/login/auth_textformfield.dart';
import '../widgets/login/login_container.dart';
import '../widgets/login/login_workflow_animated_switcher.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';
  static const double widgetSpacing = 10;
  static const double flatButtonHeight = 30;
  static const double raisedButtonHeight = 40;
  static const double textFormFieldHeight = 50;

  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginWorkflowHandler>(
        builder: (context, loginWorkflowProvider, _) {
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
                          validator: AuthenticationValidator.validateEmail,
                          errorTextValidator: AuthenticationValidator.validateEmail,
                        ),
                        SizedBox(
                          height: LoginScreen.widgetSpacing,
                        ),
                        Visibility(
                          visible: loginWorkflowProvider.isLoginOrSignup,
                          child: Column(
                            children: <Widget>[
                              AuthTextFormField(
                                key: Key('password_field'),
                                keyboardType: TextInputType.visiblePassword,
                                hintText: 'password',
                                hintTextOnFocus: 'your password',
                                labelText: 'password',
                                icon: Icons.lock,
                                obscureText: true,
                                validator: AuthenticationValidator.validatePassword,
                                errorTextValidator: AuthenticationValidator.validatePassword,
                              ),
                            ],
                          ),
                        ),
                        LoginWorkflowAnimatedSwitcher(
                          key: Key('login_workflow_animated_switcher'),
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
    });
  }
}
