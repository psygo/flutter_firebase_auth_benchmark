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

class LoginWorkflowHandler extends ChangeNotifier {
  LoginSubWorkflow _loginSubWorkflow = LoginSubWorkflow.login;

  LoginWorkflowHandler();

  bool get isLoginOrSignup =>
      _loginSubWorkflow == LoginSubWorkflow.login ||
      _loginSubWorkflow == LoginSubWorkflow.signup;

  Widget get widget {
    switch (_loginSubWorkflow) {
      case LoginSubWorkflow.login:
        return LoginWorkflow(key: Key('login_workflow'));
        break;
      case LoginSubWorkflow.passwordReset:
        return PasswordResetWorkflow(key: Key('password_reset_workflow'));
        break;
      case LoginSubWorkflow.signup:
        return SignupWorkflow(key: Key('signup_workflow'));
        break;
      default:
        throw InvalidLoginWorkFlowException(
            'There should only be 3 types of login sub workflows.');
    }
  }

  double get workflowHeight {
    double height;
    const double padding = 165;

    switch (_loginSubWorkflow) {
      case LoginSubWorkflow.login:
        height = LoginWorkflow.height;
        break;
      case LoginSubWorkflow.passwordReset:
        height = PasswordResetWorkflow.height;
        return height + 100;
        break;
      case LoginSubWorkflow.signup:
        height = SignupWorkflow.height;
        break;
      default:
        throw InvalidLoginWorkFlowException(
            'There should only be 3 types of login sub workflows.');
    }

    height += padding;
    return height;
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
