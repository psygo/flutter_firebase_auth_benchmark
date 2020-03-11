import 'package:flutter/foundation.dart';

import '../exceptions/login.dart';

enum LoginSubWorkflow {
  login,
  passwordReset,
  signup,
}

class LoginWorkflowProvider extends ChangeNotifier {
  LoginSubWorkflow _loginSubWorkflow;

  LoginWorkflowProvider() : _loginSubWorkflow = LoginSubWorkflow.login;

  bool get _isLoginWorkFlow => _loginSubWorkflow == LoginSubWorkflow.login;
  bool get _isResetWorkflow =>
      _loginSubWorkflow == LoginSubWorkflow.passwordReset;
  bool get _isSignUpWorkflow => _loginSubWorkflow == LoginSubWorkflow.signup;
  bool get _isLoginOrResetWorkFlow =>
    _loginSubWorkflow == LoginSubWorkflow.login || _loginSubWorkflow == LoginSubWorkflow.passwordReset;

  void _switchWorkFlow(LoginSubWorkflow loginSubWorkflow) {
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
        throw InvalidLoginWorkFlowException('This workflow should not exist.');
    }

    notifyListeners();
  }
}