import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class AuthTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final String hintText;
  final String hintTextOnFocus;
  final String labelText;
  final IconData icon;
  final bool obscureText;

  const AuthTextFormField({
    Key key,
    this.keyboardType,
    this.hintText,
    this.hintTextOnFocus = '',
    this.labelText,
    this.icon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  AuthTextFormFieldState createState() => AuthTextFormFieldState();
}

@visibleForTesting
class AuthTextFormFieldState extends State<AuthTextFormField> {
  bool _passwordIsNotVisible;
  Key _visibilityIconKey;
  IconData _visibilityIcon;
  FocusNode _focusNode;

  @visibleForTesting
  bool get textIsVisible => !_passwordIsNotVisible;

  @override
  void initState() {
    _passwordIsNotVisible = widget.obscureText;
    _switchIcons();
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _switchIcons() {
    _visibilityIconKey = _passwordIsNotVisible
        ? Key('password_is_visible_icon')
        : Key('password_is_not_visible_icon');
    _visibilityIcon =
        _passwordIsNotVisible ? Icons.visibility : Icons.visibility_off;
  }

  void _switchVisibility() {
    setState(() {
      _passwordIsNotVisible = !_passwordIsNotVisible;
      _switchIcons();
    });
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: _passwordIsNotVisible,
      focusNode: _focusNode,
      onTap: _requestFocus,
      decoration: InputDecoration(
        hintText:
            _focusNode.hasFocus ? widget.hintTextOnFocus : widget.hintText,
        labelText: widget.labelText,
        prefixIcon: Icon(
          widget.icon,
          color: AuthTextFormFieldColors.prefixIconColor,
        ),
        suffixIcon: Visibility(
          visible: widget.obscureText,
          child: IconButton(
            key: _visibilityIconKey,
            icon: Icon(
              _visibilityIcon,
              color: AuthTextFormFieldColors.suffixIconColor,
            ),
            onPressed: _switchVisibility,
          ),
        ),
      ),
    );
  }
}
