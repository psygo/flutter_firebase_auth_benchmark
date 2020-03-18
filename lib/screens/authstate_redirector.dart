import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'logged_in_screen.dart';
import 'login_screen.dart';
import '../providers/firebase_auth.dart';

class AuthStateRedirector extends StatelessWidget {
  static const String id = 'authstate_redirector';

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, _) {
        return StreamBuilder<FirebaseUser>(
          stream: AuthInterface.fireAuthInstance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              auth.updateCurrentUserFromFirebase();
              return LoggedInScreen();
            } else {
              return LoginScreen();
            }
          },
        );
      },
    );
  }
}
