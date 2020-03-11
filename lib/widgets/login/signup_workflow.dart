import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'button_alignment_wrapper.dart';
import '../../providers/login_workflow_provider.dart';
import '../../theme/auxiliary_theming.dart';
import '../../theme/colors.dart';

class SignupWorkflow extends StatelessWidget {
  const SignupWorkflow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginWorkflowProvider>(
        builder: (context, loginWorkflowProvider, _) {
      return Column(
        children: <Widget>[
          ButtonAlignmentWrapper(
            height: 30,
            child: FlatButton(
              key: Key('cancel_signup_button'),
              onPressed: () =>
                  loginWorkflowProvider.switchWorkFlow(LoginSubWorkflow.login),
              child: Text(
                'CANCEL SIGN UP',
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
        ],
      );
    });
  }
}
