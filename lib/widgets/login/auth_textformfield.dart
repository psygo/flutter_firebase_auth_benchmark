import 'package:flutter/material.dart';

import '../utils/text_form_field_without_errortext.dart';
import '../../exceptions/login.dart';
import '../../theme/theme.dart';
import '../../theme/colors.dart';

enum LabelStatus {
  error,
  success,
}

class AuthTextFormField extends StatefulWidget {
  static const String tickSymbol = '\u{2713}';

  final TextInputType keyboardType;
  final String hintText;
  final String hintTextOnFocus;
  final String labelText;
  final String errorMsgFromServer;
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
    this.errorMsgFromServer,
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
  Color _borderColor;

  @visibleForTesting
  bool get textIsVisible => !_passwordIsNotVisible;

  FontWeight get _labelTextFontWeight {
    if (_labelText == widget.labelText) {
      return FontWeight.normal;
    } else if (_labelText == AuthTextFormField.tickSymbol) {
      return FontWeight.w900;
    } else {
      return FontWeight.w500;
    }
  }

  @override
  void initState() {
    _passwordIsNotVisible = widget.obscureText;
    _switchIcons();
    _focusNode = FocusNode();
    _labelText = widget.labelText;
    _labelTextColor = AuthTextFormFieldColors.labelText;
    _borderColor = AuthTextFormFieldColors.border;
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

  void _switchLabelColors(LabelStatus labelStatus) {
    switch (labelStatus) {
      case LabelStatus.error:
        _labelTextColor = AuthTextFormFieldColors.labelTextError;
        _borderColor = AuthTextFormFieldColors.borderError;
        break;
      case LabelStatus.success:
        _labelTextColor = AuthTextFormFieldColors.labelTextSuccess;
        _borderColor = AuthTextFormFieldColors.borderSuccess;
        break;
      default:
        throw IllegalLabelStatus(
            'There are only two possible label statuses: error and success.');
    }
  }

  void _updateLabelText(String text) {
    final String newLabelText = widget.labelTextValidator?.call(text);
    setState(() {
      if (newLabelText != null) {
        _labelText = newLabelText;
        _switchLabelColors(LabelStatus.error);
      } else {
        _labelText = AuthTextFormField.tickSymbol;
        _switchLabelColors(LabelStatus.success);
      }
    });
  }

  void _onChangedAndUpdateLabelText(String text) {
    widget.onChanged?.call(text);
    _updateLabelText(text);
  }

  void _serverErrorOrNot(String text) {
    setState(() {
      if (widget.errorMsgFromServer != null) {
        _labelText = widget.errorMsgFromServer;
        _switchLabelColors(LabelStatus.error);
      }
    });
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
      onSaved: _serverErrorOrNot,
      decoration: InputDecoration(
        focusedBorder: Theming.authTextFormField.focusedBorder.copyWith(
          borderSide: BorderSide(
            color: _borderColor,
          ),
        ),
        labelStyle: Theming.authTextFormField.labelStyle.copyWith(
          color: _labelTextColor,
          fontWeight: _labelTextFontWeight,
        ),
        hintText:
            _focusNode.hasFocus ? widget.hintTextOnFocus : widget.hintText,
        labelText: _labelText,
        prefixIcon: Icon(
          widget.icon,
          color: AuthTextFormFieldColors.prefixIcon,
        ),
        suffixIcon: Visibility(
          visible: widget.obscureText,
          child: IconButton(
            key: _visibilityIconKey,
            icon: Icon(
              _visibilityIcon,
              color: AuthTextFormFieldColors.suffixIcon,
            ),
            onPressed: _switchVisibility,
          ),
        ),
      ),
    );
  }
}
