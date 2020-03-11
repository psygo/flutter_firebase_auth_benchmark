import 'package:flutter/material.dart';

import '../../widgets/login/auth_textformfield.dart';
import '../../theme/colors.dart';
import '../../theme/auxiliary_theming.dart';
import '../../screens/login_screen.dart';
import 'button_alignment_wrapper.dart';

class LoginWorkFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AuthTextFormField(
          key: Key('password_field'),
          keyboardType: TextInputType.visiblePassword,
          hintText: 'password',
          hintTextOnFocus: 'your password',
          labelText: 'password',
          icon: Icons.lock,
          obscureText: true,
        ),
        ButtonAlignmentWrapper(
          height: 30,
          child: FlatButton(
            key: Key('forgot_password_button'),
            onPressed: () => null,
                // _switchWorkFlow(LoginSubWorkflow.passwordReset),
            child: Text(
              'Forgot, huh?',
              style: TextStyle(
                color: BasicColors.grey600,
              ),
            ),
          ),
        ),
        ButtonAlignmentWrapper(
          height: 30,
          child: FlatButton(
            key: Key('signup_button'),
            onPressed: () => null,
                // _switchWorkFlow(LoginSubWorkflow.signUp),
            child: Text(
              'SIGN UP',
              style: TextStyle(
                color: BasicColors.blue,
              ),
            ),
          ),
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
    );
  }
}