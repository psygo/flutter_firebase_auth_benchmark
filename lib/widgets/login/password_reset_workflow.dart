import 'package:flutter/material.dart';

import '../../widgets/login/auth_textformfield.dart';
import '../../theme/colors.dart';
import '../../theme/auxiliary_theming.dart';
import '../../screens/login_screen.dart';
import 'button_alignment_wrapper.dart';

class PasswordResetWorkflow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ButtonAlignmentWrapper(
          height: 30,
          child: FlatButton(
            key: Key('cancel_reset_button'),
            onPressed: () => null,
              // _switchWorkFlow(LoginSubWorkflow.login),
            child: Text(
              'CANCEL RESET',
              style: TextStyle(
                color: BasicColors.blue,
              ),
            ),
          ),
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
  }
}