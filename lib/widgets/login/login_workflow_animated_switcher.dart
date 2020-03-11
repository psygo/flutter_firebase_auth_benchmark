import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_workflow_provider.dart';
import 'login_workflow.dart';
import 'password_reset_workflow.dart';
import 'signup_workflow.dart';
import '../../providers/login_workflow_provider.dart';
import '../../exceptions/login.dart';

class LoginWorkflowAnimatedSwitcher extends StatelessWidget {
  // final Widget _loginSubWorkflow;

  LoginWorkflowAnimatedSwitcher({
    Key key,
    // LoginSubWorkflow loginSubWorkflow,
  }) : 
    // _loginSubWorkflow = _selectLoginSubWorkflow(loginSubWorkflow),
    super(key: key);

  // static Widget _selectLoginSubWorkflow(LoginSubWorkflow passwordOrMsg){
  //   switch (passwordOrMsg){
  //     case LoginSubWorkflow.login:
  //       return LoginWorkFlow();
  //       break;
  //     case LoginSubWorkflow.passwordReset:
  //       return PasswordResetWorkflow();
  //       break;
  //     case LoginSubWorkflow.signup:
  //       return SignupWorkflow();
  //       break;
  //     default:
  //       throw InvalidLoginWorkFlowException(
  //         'There should only be 3 types of login sub workflows.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginWorkflowProvider>(
      builder: (context, loginWorkflowProvider, child){
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 1500),
          switchInCurve: Curves.bounceOut,
          switchOutCurve: Curves.easeInExpo,
          child: loginWorkflowProvider.widget,
        );
      }
    );
  }
}