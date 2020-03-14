import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_benchmark/authentication/validator.dart';

import '../../theme/colors.dart';

class AuthTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final String hintText;
  final String hintTextOnFocus;
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final String Function(String) validator;
  final String Function(String) labelTextValidator;

  const AuthTextFormField({
    Key key,
    this.keyboardType,
    this.hintText,
    this.hintTextOnFocus = '',
    this.labelText,
    this.icon,
    this.obscureText = false,
    this.validator,
    this.labelTextValidator,
  }) : super(key: key);

  @override
  AuthTextFormFieldState createState() => AuthTextFormFieldState();
}

@visibleForTesting
class AuthTextFormFieldState extends State<AuthTextFormField> {
  final TextEditingController _textEditingController = TextEditingController();

  bool _passwordIsNotVisible;
  Key _visibilityIconKey;
  IconData _visibilityIcon;
  FocusNode _focusNode;
  String Function(String) _errorTextValidator;
  String _labelText;
  Color _labelTextColor;

  @visibleForTesting
  bool get textIsVisible => !_passwordIsNotVisible;

  @override
  void initState() {
    _passwordIsNotVisible = widget.obscureText;
    _switchIcons();
    super.initState();
    _focusNode = FocusNode();
    _errorTextValidator = widget.labelTextValidator;
    _labelText = widget.labelText;
    _labelTextColor = AuthTextFormFieldColors.labelTextColor;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
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

  String _labelTextValidatorShieldCall(String text) =>
      _errorTextValidator == null ? null : _errorTextValidator(text);

  void _updateLabelText(String text){
    final String newLabelText = _labelTextValidatorShieldCall(text);
    setState(() {
      if (newLabelText != null){
        _labelText = newLabelText;
        _labelTextColor = AuthTextFormFieldColors.labelTextErrorColor;
      } else {
        _labelText = widget.labelText;
        _labelTextColor = AuthTextFormFieldColors.labelTextColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: _passwordIsNotVisible,
      focusNode: _focusNode,
      onTap: _requestFocus,
      onChanged: (String text) => _updateLabelText(text),
      decoration: InputDecoration(
        hintText:
            _focusNode.hasFocus ? widget.hintTextOnFocus : widget.hintText,
        labelText: _labelText,
        labelStyle: TextStyle(
          color: _labelTextColor,
        ),
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
