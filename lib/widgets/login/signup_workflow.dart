import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_benchmark/authentication/validator.dart';
import 'package:provider/provider.dart';

import 'auth_textformfield.dart';
import 'button_alignment_wrapper.dart';
import '../../providers/login_workflow_provider.dart';
import '../../screens/login_screen.dart';
import '../../theme/auxiliary_theming.dart';
import '../../theme/colors.dart';

class SignupWorkflow extends StatelessWidget {
  static final double height = LoginScreen.textFormFieldHeight +
      LoginScreen.flatButtonHeight +
      LoginScreen.raisedButtonHeight +
      2 * LoginScreen.widgetSpacing;

  const SignupWorkflow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginWorkflowHandler>(
        builder: (context, loginWorkflowProvider, _) {
      String partialValidateConfirmPassword(String confirmPassword) =>
          AuthenticationValidator.validateConfirmPassword(
              loginWorkflowProvider.password, confirmPassword);

      return Column(
        children: <Widget>[
          SizedBox(
            height: LoginScreen.widgetSpacing,
          ),
          AuthTextFormField(
            key: Key('confirm_password_field'),
            keyboardType: TextInputType.visiblePassword,
            hintText: 'confirm your password',
            hintTextOnFocus: 'your password again',
            labelText: 'confirm password',
            icon: Icons.lock,
            obscureText: true,
            validator: partialValidateConfirmPassword,
            labelTextValidator: partialValidateConfirmPassword,
          ),
          SizedBox(
            height: LoginScreen.widgetSpacing,
          ),
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
          SizedBox(
            height: LoginScreen.widgetSpacing,
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
                onPressed: () {
                  if (loginWorkflowProvider.formKey.currentState.validate()) {
                    print('validated');
                  }
                },
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
