import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_textformfield.dart';
import 'button_alignment_wrapper.dart';
import '../../providers/firebase_auth.dart';
import '../../authentication/validator.dart';
import '../../providers/login_workflow_provider.dart';
import '../../screens/logged_in_screen.dart';
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
                  loginWorkflowProvider.switchWorkFlow(LoginSubWorkflow.signIn),
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
          Consumer<Auth>(
            builder: (context, auth, _) {
              return ButtonAlignmentWrapper(
                height: 40,
                child: SizedBox(
                  width: 165,
                  child: RaisedButton(
                    key: Key('create_account_button'),
                    elevation: AuxiliaryTheming.raisedButtonElevation,
                    color: BasicColors.blue,
                    textColor: BasicColors.white,
                    onPressed: () async {
                      if (loginWorkflowProvider.validate()) {
                        await auth.signUp(
                            email: loginWorkflowProvider.email,
                            password: loginWorkflowProvider.password);

                        await loginWorkflowProvider.save();

                        if (auth.noErrorOccurred) {
                          await Navigator.pushNamed(context, LoggedInScreen.id);
                        }
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
              );
            },
          ),
        ],
      );
    });
  }
}
