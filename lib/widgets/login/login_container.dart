import 'package:flutter/material.dart';

import '../../theme/auxiliary_theming.dart';
import '../../theme/colors.dart';

class LoginContainer extends StatelessWidget {
  final Widget child;

  const LoginContainer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 275,
      margin: EdgeInsets.all(
        10,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: BasicColors.white,
        boxShadow: [
          AuxiliaryTheming.containerBoxShadow,
        ],
        borderRadius: AuxiliaryTheming.containerBorderRadius,
      ),
      child: child,
    );
  }
}
