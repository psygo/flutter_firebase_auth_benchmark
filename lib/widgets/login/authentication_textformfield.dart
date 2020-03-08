import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class AuthenticationTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final IconData icon;
  final bool obscureText;

  const AuthenticationTextFormField({
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
  Key _visibilityIconKey;
  IconData _visibilityIcon;

  bool get _doNotObscureText => !widget.obscureText;

  @override
  void initState() {
    _passwordIsVisible = widget.obscureText;
    _switchIcons();
    super.initState();
  }

  void _switchIcons() {
    _visibilityIconKey = _passwordIsVisible
        ? Key('password_is_visible_icon')
        : Key('password_is_not_visible_icon');
    _visibilityIcon =
        _passwordIsVisible ? Icons.visibility : Icons.visibility_off;
  }

  void _switchVisibility() {
    setState(() {
      _passwordIsVisible = !_passwordIsVisible;
      _switchIcons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: _passwordIsVisible,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: Icon(
          widget.icon,
          color: prefixIconColor,
        ),
        suffixIcon: _doNotObscureText
            ? null
            : IconButton(
                key: _visibilityIconKey,
                icon: Icon(
                  _visibilityIcon,
                  color: suffixIconColor,
                ),
                onPressed: _switchVisibility,
              ),
      ),
    );
  }
}
