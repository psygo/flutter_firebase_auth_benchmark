import 'package:flutter/material.dart';

class AuthenticationTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;

  const AuthenticationTextFormField({
    Key key,
    this.hintText,
    this.labelText,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(
          icon,
        ),
      ),
    );
  }
}
