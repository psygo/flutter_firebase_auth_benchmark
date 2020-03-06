import 'package:flutter/material.dart';

class LoginContainer extends StatelessWidget {
  final Widget child;

  const LoginContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 275,
      margin: EdgeInsets.all(
        10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            blurRadius: 6,
            spreadRadius: 3,
            offset: Offset(
              7,
              7,
            ),
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(
            15,
          ),  
        ),
      ),
      child: child,
    );
  }
}