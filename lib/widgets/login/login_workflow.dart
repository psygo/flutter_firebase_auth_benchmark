import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'button_alignment_wrapper.dart';
import '../../providers/login_workflow_provider.dart';
import '../../screens/login_screen.dart';
import '../../theme/auxiliary_theming.dart';
import '../../theme/colors.dart';

class LoginWorkflow extends StatelessWidget {
  static final double height = 2 * LoginScreen.flatButtonHeight +
      LoginScreen.raisedButtonHeight +
      2 * LoginScreen.widgetSpacing;

  const LoginWorkflow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginWorkflowHandler>(
      builder: (context, loginWorkflowProvider, _) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: LoginScreen.widgetSpacing,
            ),
            ButtonAlignmentWrapper(
              height: LoginScreen.flatButtonHeight,
              child: FlatButton(
                key: Key('forgot_password_button'),
                onPressed: () => loginWorkflowProvider
                    .switchWorkFlow(LoginSubWorkflow.passwordReset),
                child: Text(
                  'Forgot, huh?',
                  style: TextStyle(
                    color: BasicColors.grey600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: LoginScreen.widgetSpacing,
            ),
            ButtonAlignmentWrapper(
              height: LoginScreen.flatButtonHeight,
              child: FlatButton(
                key: Key('signup_button'),
                onPressed: () => loginWorkflowProvider
                    .switchWorkFlow(LoginSubWorkflow.signup),
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: BasicColors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: LoginScreen.widgetSpacing,
            ),
            ButtonAlignmentWrapper(
              height: LoginScreen.raisedButtonHeight,
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
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
