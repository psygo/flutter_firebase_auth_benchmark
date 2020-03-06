import 'package:flutter/material.dart';

class AuthenticationTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final IconData icon;
  final bool obscureText;

  AuthenticationTextFormField({
    Key key,
    this.keyboardType,
    this.hintText,
    this.labelText,
    this.icon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _AuthenticationTextFormFieldState createState() =>
      _AuthenticationTextFormFieldState();
}

class _AuthenticationTextFormFieldState
    extends State<AuthenticationTextFormField> {
  bool _passwordIsVisible;

  bool get _passwordIsNotVisible => !_passwordIsVisible;
  bool get _doNotObscureText => !widget.obscureText;

  @override
  void initState() {
    _passwordIsVisible = widget.obscureText;
    super.initState();
  }

  void _switchVisibility() {
    setState(() {
      _passwordIsVisible = !_passwordIsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: _passwordIsNotVisible,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: Icon(
          widget.icon,
        ),
        suffixIcon: _doNotObscureText
            ? null
            : IconButton(
                icon: Icon(
                  _passwordIsVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _switchVisibility,
              ),
      ),
    );
  }
}
