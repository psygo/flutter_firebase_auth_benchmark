import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AuxiliaryTheming {
  static const double textFieldHeight = 40;

  static final BoxShadow containerBoxShadow = BoxShadow(
    color: LoginContainerColors.containerShadowGrey,
    blurRadius: 4,
    spreadRadius: 2,
    offset: Offset(
      5,
      5,
    ),
  );

  static const BorderRadius containerBorderRadius = BorderRadius.all(
    Radius.circular(
      15,
    ),
  );

  static const BorderRadius infiniteCircularBorderRadius = BorderRadius.all(
    Radius.circular(
      1000,
    ),
  );

  static const double raisedButtonElevation = 5;
}
