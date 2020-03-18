import 'package:flutter/material.dart';

import 'auxiliary_theming.dart';
import 'colors.dart';

abstract class Theming {
  static final ThemeData appTheme = ThemeData(
    inputDecorationTheme: authTextFormFieldTheme,
    buttonTheme: flatButtonTheme,
    iconTheme: defaultIconTheme,
  );

  static const IconThemeData defaultIconTheme = IconThemeData(
    color: BasicColors.grey,
  );

  static final InputDecorationTheme authTextFormFieldTheme =
      InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
      vertical: 15,
    ),
    fillColor: AuthTextFormFieldColors.fill,
    filled: true,
    labelStyle: TextStyle(
      color: AuthTextFormFieldColors.labelText,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AuxiliaryTheming.infiniteCircularBorderRadius,
      borderSide: BorderSide(
        color: AuthTextFormFieldColors.enabledBorder,
      ),
    ),
    focusedBorder: AuxiliaryTheming.authTextFormFieldStandardBorder,
    errorBorder: OutlineInputBorder(
      borderRadius: AuxiliaryTheming.infiniteCircularBorderRadius,
      borderSide: BorderSide(
        color: AuthTextFormFieldColors.enabledBorder,
      ),
    ),
    errorStyle: TextStyle(
      color: AuthTextFormFieldColors.errorText,
    ),
    errorMaxLines: 1,
    focusedErrorBorder: AuxiliaryTheming.authTextFormFieldStandardBorder,
  );

  static const ButtonThemeData flatButtonTheme = ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: AuxiliaryTheming.infiniteCircularBorderRadius,
    ),
    minWidth: 100,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: EdgeInsets.all(0),
  );
}
