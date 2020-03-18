import 'package:flutter/material.dart';

abstract class BasicColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static final Color grey600 = Colors.grey[600];
  static final Color grey800 = Colors.grey[800];
  static const Color lightBlueGrey = Color(0xFFEEF5FB);
  static const Color blue = Colors.blue;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static final Color lightRed = Colors.red[400];
  static const Color transparent = Colors.transparent;
}

abstract class LoginContainerColors {
  static final Color containerShadowGrey = BasicColors.grey800;
}

abstract class AuthTextFormFieldColors {
  static final Color prefixIcon = BasicColors.grey600;
  static final Color suffixIcon = BasicColors.grey600;
  static final Color labelText = BasicColors.grey800;
  static const Color labelTextSuccess = BasicColors.green;
  static final Color labelTextError = BasicColors.lightRed;
  static const Color border = BasicColors.grey;
  static final Color borderError = BasicColors.lightRed;
  static const Color borderSuccess = BasicColors.green;
  static const Color enabledBorder = BasicColors.transparent;
  static const Color focusedBorder = BasicColors.grey;
  static const Color fill = BasicColors.lightBlueGrey;
  static const Color errorText = BasicColors.red;
}
