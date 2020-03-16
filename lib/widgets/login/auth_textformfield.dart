import 'package:flutter/material.dart';

import '../utils/text_form_field_without_errortext.dart';
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
  final void Function(String) onChanged;

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
    this.onChanged,
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
  String _labelText;
  Color _labelTextColor;

  @visibleForTesting
  bool get textIsVisible => !_passwordIsNotVisible;

  @override
  void initState() {
    _passwordIsNotVisible = widget.obscureText;
    _switchIcons();
    _focusNode = FocusNode();
    _labelText = widget.labelText;
    _labelTextColor = AuthTextFormFieldColors.labelTextColor;
    super.initState();
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
      widget.labelTextValidator != null
          ? widget.labelTextValidator(text)
          : null;

  void _updateLabelText(String text) {
    final String newLabelText = _labelTextValidatorShieldCall(text);
    setState(() {
      if (newLabelText != null) {
        _labelText = newLabelText;
        _labelTextColor = AuthTextFormFieldColors.labelTextErrorColor;
      } else {
        _labelText = widget.labelText;
        _labelTextColor = AuthTextFormFieldColors.labelTextColor;
      }
    });
  }

  void _onChangedShieldCall(String text) =>
      widget.onChanged != null ? widget.onChanged(text) : null;

  void _onChangedAndUpdateLabelText(String text) {
    _onChangedShieldCall(text);
    _updateLabelText(text);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWithErrorTextOption(
      errorTextPresent: false,
      controller: _textEditingController,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: _passwordIsNotVisible,
      focusNode: _focusNode,
      onTap: _requestFocus,
      onChanged: (String text) => _onChangedAndUpdateLabelText(text),
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
