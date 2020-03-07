import 'package:flutter/material.dart';

import 'auxiliary_theming.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  inputDecorationTheme: authenticationTextFormFieldTheme,
  buttonTheme: flatButtonTheme,
);

final InputDecorationTheme authenticationTextFormFieldTheme =
    InputDecorationTheme(
  enabledBorder: OutlineInputBorder(
    borderRadius: infiniteCircularBorderRadius,
    borderSide: BorderSide(
      color: enabledBorderColor,
    ),
  ),
  fillColor: fillColor,
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderRadius: infiniteCircularBorderRadius,
    borderSide: BorderSide(
      color: focusedBorderColor,
    ),
  ),
  contentPadding: EdgeInsets.symmetric(
    vertical: 15,
  ),
);

final ButtonThemeData flatButtonTheme = ButtonThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: infiniteCircularBorderRadius,
  ),
  minWidth: 100,
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  padding: EdgeInsets.all(0),
);