import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_benchmark/providers/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../authentication/validator.dart';
import '../providers/login_workflow_provider.dart';
import '../theme/colors.dart';
import '../widgets/login/auth_textformfield.dart';
import '../widgets/login/login_container.dart';
import '../widgets/login/login_workflow_animated_switcher.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  static const double widgetSpacing = 10;
  static const double flatButtonHeight = 30;
  static const double raisedButtonHeight = 40;
  static const double textFormFieldHeight = 50;

  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Auth notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final LoginWorkflowHandler loginWorkflowProvider =
        Provider.of<LoginWorkflowHandler>(context);
    loginWorkflowProvider.formKey = _formKey;

    // final Auth notifier = Provider.of<Auth>(context);

    // if (this.notifier != notifier) this.notifier = notifier;
  }

  // String _erroMsg;

  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() => _erroMsg = Provider.of<Auth>(context).errorMsg);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: BasicColors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LoginContainer(
                  child: Consumer<LoginWorkflowHandler>(
                    builder: (context, loginWorkflowProvider, _) {
                      return Consumer<Auth>(
                        builder: (context, auth, _) {
                          return Form(
                            key: _formKey,
                            child: ListView(
                              children: <Widget>[
                                AuthTextFormField(
                                  key: Key('email_field'),
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'email',
                                  hintTextOnFocus: 'your email',
                                  labelText: 'email',
                                  icon: Icons.account_circle,
                                  validator:
                                      AuthenticationValidator.validateEmail,
                                  labelTextValidator:
                                      AuthenticationValidator.validateEmail,
                                  onChanged: (String text) =>
                                      loginWorkflowProvider.email = text,
                                  errorMsgFromServer: auth.errorMsg,
                                ),
                                SizedBox(
                                  height: LoginScreen.widgetSpacing,
                                ),
                                Visibility(
                                  visible:
                                      loginWorkflowProvider.isLoginOrSignup,
                                  child: Column(
                                    children: <Widget>[
                                      AuthTextFormField(
                                        key: Key('password_field'),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        hintText: 'password',
                                        hintTextOnFocus: 'your password',
                                        labelText: 'password',
                                        icon: Icons.lock,
                                        obscureText: true,
                                        validator: AuthenticationValidator
                                            .validatePassword,
                                        labelTextValidator:
                                            AuthenticationValidator
                                                .validatePassword,
                                        onChanged: (String text) =>
                                            loginWorkflowProvider.password =
                                                text,
                                      ),
                                    ],
                                  ),
                                ),
                                LoginWorkflowAnimatedSwitcher(
                                  key: Key('login_workflow_animated_switcher'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
