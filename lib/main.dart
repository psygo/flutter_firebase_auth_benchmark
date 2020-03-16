import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication/firebase.dart';
import 'providers/login_workflow_provider.dart';
import 'screens/logged_in_screen.dart';
import 'screens/login_screen.dart';
import 'theme/theme.dart';

void main() => runApp(FirebaseAuthenticationApp());

class FirebaseAuthenticationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginWorkflowHandler()),
        ChangeNotifierProvider(create: (_) => Auth()),
      ],
      child: MaterialApp(
          theme: Theming.appTheme,
          initialRoute: LoginScreen.id,
          routes: {
            LoginScreen.id: (_) => LoginScreen(),
            LoggedInScreen.id: (_) => LoggedInScreen(),
          }),
    );
  }
}
