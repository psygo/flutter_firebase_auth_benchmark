import 'package:flutter/material.dart';

abstract class BasicColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static final Color grey600 = Colors.grey[600];
  static final Color grey800 = Colors.grey[800];
  static const Color blue = Colors.blue;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static final Color lightRed = Colors.red[400];
  static const Color transparent = Colors.transparent;
}

class LoginContainerColors {
  static final Color containerShadowGrey = BasicColors.grey800;
}

class AuthTextFormFieldColors {
  static final Color prefixIconColor = BasicColors.grey600;
  static final Color suffixIconColor = BasicColors.grey600;
  static final Color labelTextColor = BasicColors.grey800;
  static final Color borderColor = BasicColors.grey;
  static final Color borderErrorColor = BasicColors.lightRed;
  static final Color borderSuccessColor = BasicColors.green;
  static final Color enabledBorderColor = BasicColors.transparent;
  static final Color focusedBorderColor = BasicColors.grey;
  static const Color fillColor = Color(0xFFEEF5FB);
  static const Color errorTextColor = BasicColors.red;
}
