import 'package:flutter/material.dart';

class ButtonAlignmentWrapper extends StatelessWidget {
  final double height;
  final Widget child;

  const ButtonAlignmentWrapper({
    Key key,
    @required this.height,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}