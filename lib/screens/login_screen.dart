import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_benchmark/widgets/login/login_workflow_animated_switcher.dart';
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

class LoginScreen extends StatefulWidget {
  static const double widgetSpacing = 10;

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
                        height: LoginScreen.widgetSpacing,
                      ),
                      LoginWorkflowAnimatedSwitcher(),
                      // LoginWorkflow(),
                      // SignupWorkflow(),
                      // PasswordResetWorkflow(),
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

