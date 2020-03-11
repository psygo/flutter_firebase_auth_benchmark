import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'button_alignment_wrapper.dart';
import '../../providers/login_workflow_provider.dart';
import '../../screens/login_screen.dart';
import '../../theme/auxiliary_theming.dart';
import '../../theme/colors.dart';

class PasswordResetWorkflow extends StatelessWidget {
  const PasswordResetWorkflow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginWorkflowHandler>(
        builder: (context, loginWorkflowProvider, _) {
      return Column(
        children: <Widget>[
          SizedBox(
            key: Key('password_reset_msg'),
            height: AuxiliaryTheming.textFieldHeight,
            child: Center(
              child: Text(
                'Please type your recovery email.',
              ),
            ),
          ),
          SizedBox(
            height: LoginScreen.widgetSpacing,
          ),
          ButtonAlignmentWrapper(
            height: 30,
            child: FlatButton(
              key: Key('cancel_reset_button'),
              onPressed: () =>
                  loginWorkflowProvider.switchWorkFlow(LoginSubWorkflow.login),
              child: Text(
                'CANCEL RESET',
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
        ],
      );
    });
  }
}
