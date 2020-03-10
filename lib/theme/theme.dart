import 'package:flutter/material.dart';

import 'auxiliary_theming.dart';
import 'colors.dart';

class Theming {
  static final ThemeData appTheme = ThemeData(
    inputDecorationTheme: authenticationTextFormFieldTheme,
    buttonTheme: flatButtonTheme,
    iconTheme: defaultIconTheme,
  );

  static final IconThemeData defaultIconTheme = IconThemeData(
    color: BasicColors.grey,
  );

  static final InputDecorationTheme authenticationTextFormFieldTheme =
      InputDecorationTheme(
    labelStyle: TextStyle(
      color: AuthTextFormFieldColors.labelTextColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AuxiliaryTheming.infiniteCircularBorderRadius,
      borderSide: BorderSide(
        color: AuthTextFormFieldColors.enabledBorderColor,
      ),
    ),
    fillColor: AuthTextFormFieldColors.fillColor,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: AuxiliaryTheming.infiniteCircularBorderRadius,
      borderSide: BorderSide(
        color: AuthTextFormFieldColors.focusedBorderColor,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 15,
    ),
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
