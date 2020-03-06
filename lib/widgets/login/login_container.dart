import 'package:flutter/material.dart';

import '../../theme/auxiliary_theming.dart';
import '../../theme/colors.dart';

class LoginContainer extends StatelessWidget {
  final Widget child;

  const LoginContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      width: 275,
      margin: EdgeInsets.all(
        10,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          containerBoxShadow,
        ],
        borderRadius: containerBorderRadius,
      ),
      child: child,
    );
  }
}
