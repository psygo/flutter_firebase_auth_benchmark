import 'package:flutter/material.dart';

import '../exceptions/login.dart';
import '../widgets/login/login_workflow.dart';
import '../widgets/login/password_reset_workflow.dart';
import '../widgets/login/signup_workflow.dart';

enum LoginSubWorkflow {
  login,
  passwordReset,
  signup,
}

class LoginWorkflowProvider extends ChangeNotifier {
  LoginSubWorkflow _loginSubWorkflow;

  LoginWorkflowProvider() : _loginSubWorkflow = LoginSubWorkflow.login;

  // bool get _isLoginWorkFlow => _loginSubWorkflow == LoginSubWorkflow.login;
  // bool get _isResetWorkflow =>
  //     _loginSubWorkflow == LoginSubWorkflow.passwordReset;
  // bool get _isSignUpWorkflow => _loginSubWorkflow == LoginSubWorkflow.signup;
  // bool get _isLoginOrResetWorkFlow =>
  //   _loginSubWorkflow == LoginSubWorkflow.login || _loginSubWorkflow == LoginSubWorkflow.passwordReset;

  Widget get widget {
    switch (_loginSubWorkflow){
      case LoginSubWorkflow.login:
        return LoginWorkflow();
        break;
      case LoginSubWorkflow.passwordReset:
        return PasswordResetWorkflow();
        break;
      case LoginSubWorkflow.signup:
        return SignupWorkflow();
        break;
      default:
        throw InvalidLoginWorkFlowException(
          'There should only be 3 types of login sub workflows.');
    }
  }

  void switchWorkFlow(LoginSubWorkflow loginSubWorkflow) {
    switch (loginSubWorkflow) {
      case LoginSubWorkflow.login:
        _loginSubWorkflow = LoginSubWorkflow.login;
        break;
      case LoginSubWorkflow.passwordReset:
        _loginSubWorkflow = LoginSubWorkflow.passwordReset;
        break;
      case LoginSubWorkflow.signup:
        _loginSubWorkflow = LoginSubWorkflow.signup;
        break;
      default:
        throw InvalidLoginWorkFlowException(
          'There should only be 3 types of login sub workflows.');
    }

    notifyListeners();
  }
}