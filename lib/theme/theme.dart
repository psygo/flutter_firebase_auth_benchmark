import 'package:flutter/material.dart';

import 'auxiliary_theming.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  inputDecorationTheme: authenticationTextFormFieldTheme,
  buttonTheme: flatButtonTheme,
  iconTheme: defaultIconTheme,
);

final IconThemeData defaultIconTheme = IconThemeData(
  color: grey,
);

final InputDecorationTheme authenticationTextFormFieldTheme =
    InputDecorationTheme(
  labelStyle: TextStyle(
    color: labelTextColor,
  ),
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
