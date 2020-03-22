import 'package:flutter/material.dart';

import '../exceptions/login.dart';
import '../widgets/login/login_workflow.dart';
import '../widgets/login/password_reset_workflow.dart';
import '../widgets/login/signup_workflow.dart';

enum LoginSubWorkflow {
  signIn,
  passwordReset,
  signUp,
}

class LoginWorkflowHandler extends ChangeNotifier {
  static const double heightPadding = 160;

  LoginSubWorkflow _loginSubWorkflow = LoginSubWorkflow.signIn;
  GlobalKey<FormState> _formKey;
  String _email;
  String _password;

  LoginWorkflowHandler();

  bool get isLoginOrSignup =>
      _loginSubWorkflow == LoginSubWorkflow.signIn ||
      _loginSubWorkflow == LoginSubWorkflow.signUp;
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
      case LoginSubWorkflow.signIn:
        return LoginWorkflow(key: Key('login_workflow'));
        break;
      case LoginSubWorkflow.passwordReset:
        return PasswordResetWorkflow(key: Key('password_reset_workflow'));
        break;
      case LoginSubWorkflow.signUp:
        return SignupWorkflow(key: Key('signup_workflow'));
        break;
      default:
        throw InvalidLoginWorkFlow(
            'There should only be 3 types of login sub workflows.');
    }
  }

  double get workflowHeight {
    double height = heightPadding;

    switch (_loginSubWorkflow) {
      case LoginSubWorkflow.signIn:
        height += LoginWorkflow.height;
        break;
      case LoginSubWorkflow.passwordReset:
        height += PasswordResetWorkflow.height - 60;
        break;
      case LoginSubWorkflow.signUp:
        height += SignupWorkflow.height;
        break;
      default:
        throw InvalidLoginWorkFlow(
            'There should only be 3 types of login sub workflows.');
    }

    return height;
  }

  void switchWorkFlow(LoginSubWorkflow loginSubWorkflow) {
    switch (loginSubWorkflow) {
      case LoginSubWorkflow.signIn:
        _loginSubWorkflow = LoginSubWorkflow.signIn;
        break;
      case LoginSubWorkflow.passwordReset:
        _loginSubWorkflow = LoginSubWorkflow.passwordReset;
        break;
      case LoginSubWorkflow.signUp:
        _loginSubWorkflow = LoginSubWorkflow.signUp;
        break;
      default:
        throw InvalidLoginWorkFlow(
            'There should only be 3 types of login sub workflows.');
    }

    notifyListeners();
  }
}
