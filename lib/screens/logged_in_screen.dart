import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../theme/colors.dart';

class LoggedInScreen extends StatelessWidget {
  static const id = 'logged_in_screen';

  String _email(FirebaseUser firebaseUser) => firebaseUser?.email ?? '';
  String _uid(FirebaseUser firebaseUser) =>
      firebaseUser?.uid?.substring(0, 8) ?? '';

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, _) {
        return Scaffold(
          body: Container(
            color: BasicColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You\'re logged in!',
                  key: Key('logged_in_text'),
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Divider(
                  thickness: 1.75,
                  height: 1,
                  indent: 150,
                  endIndent: 150,
                  color: BasicColors.black,
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 85,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'email',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_email(auth.user)}',
                            key: Key('user_email_text'),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'uid',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_uid(auth.user)}',
                            key: Key('user_uid_text'),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 175,
                )
              ],
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Logged In Screen',
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'delete_account_button',
                key: Key('delete_account_button'),
                child: Icon(
                  Icons.delete,
                ),
                onPressed: () async {
                  await auth.deleteUser();

                  await Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                heroTag: 'sign_out_button',
                key: Key('sign_out_button'),
                child: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () async {
                  await auth.signOut();

                  await Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
