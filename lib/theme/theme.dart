import 'package:flutter/material.dart';

import 'auxiliary_theming.dart';
import 'colors.dart';

abstract class Theming {
  static final ThemeData appTheme = ThemeData(
    inputDecorationTheme: authTextFormFieldTheme,
    buttonTheme: flatButtonTheme,
    iconTheme: defaultIconTheme,
  );

  static final IconThemeData defaultIconTheme = IconThemeData(
    color: BasicColors.grey,
  );

  static final InputDecorationTheme authTextFormFieldTheme =
      InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
      vertical: 15,
    ),
    fillColor: AuthTextFormFieldColors.fillColor,
    filled: true,
    labelStyle: TextStyle(
      color: AuthTextFormFieldColors.labelTextColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AuxiliaryTheming.infiniteCircularBorderRadius,
        borderSide: BorderSide(
          color: AuthTextFormFieldColors.enabledBorderColor,
        ),
    ),
    focusedBorder: AuxiliaryTheming.authTextFormFieldStandardBorder,
    errorBorder: OutlineInputBorder(
      borderRadius: AuxiliaryTheming.infiniteCircularBorderRadius,
      borderSide: BorderSide(
        color: AuthTextFormFieldColors.enabledBorderColor,
      ),
    ),
    errorStyle: TextStyle(
      color: AuthTextFormFieldColors.labelTextColor,
    ),
    errorMaxLines: 3,
    focusedErrorBorder: AuxiliaryTheming.authTextFormFieldStandardBorder,
  );

  static final ButtonThemeData flatButtonTheme = ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: AuxiliaryTheming.infiniteCircularBorderRadius,
    ),
    minWidth: 100,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: EdgeInsets.all(0),
  );
}
