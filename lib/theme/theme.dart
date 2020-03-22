import 'package:flutter/material.dart';

import 'auxiliary_theming.dart';
import 'colors.dart';

abstract class Theming {
  static final ThemeData app = ThemeData(
    inputDecorationTheme: authTextFormField,
    buttonTheme: flatButton,
    iconTheme: defaultIcon,
  );

  static const IconThemeData defaultIcon = IconThemeData(
    color: BasicColors.grey,
  );

  static final InputDecorationTheme authTextFormField = InputDecorationTheme(
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
    focusedBorder: OutlineInputBorder(
      borderRadius: AuxiliaryTheming.infiniteCircularBorderRadius,
      borderSide: BorderSide(
        color: AuthTextFormFieldColors.focusedBorder,
      ),
    ),
  );

  static const ButtonThemeData flatButton = ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: AuxiliaryTheming.infiniteCircularBorderRadius,
    ),
    minWidth: 80,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: EdgeInsets.all(0),
  );
}
