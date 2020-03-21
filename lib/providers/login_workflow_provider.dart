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
  GlobalKey<FormState> _formKey;
  String _email;
  String _password;

  LoginWorkflowHandler();

  bool get isLoginOrSignup =>
      _loginSubWorkflow == LoginSubWorkflow.login ||
      _loginSubWorkflow == LoginSubWorkflow.signup;
  String get email => _email;
  String get password => _password;

  set formKey(GlobalKey<FormState> formKey) => _formKey = formKey;
  set email(String newEmail) => _email = newEmail;
  set password(String newPassword) {
    _password = newPassword;
    notifyListeners();
  }

  bool validate() => _formKey.currentState.validate();
  Future<void> save() async =>
      await Future.delayed(Duration(milliseconds: 100), () {
        _formKey.currentState.save();
      });

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
        throw InvalidLoginWorkFlow(
            'There should only be 3 types of login sub workflows.');
    }
  }

  double get workflowHeight {
    double height;
    const double padding = 160;

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
        throw InvalidLoginWorkFlow(
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
        throw InvalidLoginWorkFlow(
            'There should only be 3 types of login sub workflows.');
    }

    notifyListeners();
  }
}
