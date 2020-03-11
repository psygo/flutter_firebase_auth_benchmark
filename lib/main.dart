import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/login_workflow_provider.dart';
import 'theme/theme.dart';
import 'screens/login_screen.dart';

void main() => runApp(FirebaseAuthenticationApp());

class FirebaseAuthenticationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginWorkflowProvider()),
      ],
      child: MaterialApp(
          theme: Theming.appTheme,
          initialRoute: LoginScreen.id,
          routes: {
            LoginScreen.id: (_) => LoginScreen(),
          }),
    );
  }
}
