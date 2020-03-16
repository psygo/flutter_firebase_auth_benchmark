import 'package:flutter/material.dart';

import '../theme/colors.dart';

class LoggedInScreen extends StatelessWidget {
  static const id = 'logged_in_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: BasicColors.white,
        child: Center(
          child: Text(
            'You\'re logged in!',
            key: Key('logged_in_text'),
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Logged In Screen',
        ),
      ),
    );
  }
}
