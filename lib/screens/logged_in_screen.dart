import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authentication/firebase_auth.dart';
import '../theme/colors.dart';

class LoggedInScreen extends StatelessWidget {
  static const id = 'logged_in_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, _) {
        return Scaffold(
          body: Container(
            color: BasicColors.white,
            child: Column(
              children: <Widget>[
                Text(
                  'You\'re logged in!',
                  key: Key('logged_in_text'),
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'email:',
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '${auth.user.email}',
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'uid:',
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '${auth.user.uid}',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              'Logged In Screen',
            ),
          ),
        );
      },
    );
  }
}
