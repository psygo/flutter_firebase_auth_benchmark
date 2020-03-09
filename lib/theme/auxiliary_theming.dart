import 'package:flutter/material.dart';

import 'colors.dart';

class AuxiliaryTheming{
  static final BoxShadow containerBoxShadow = BoxShadow(
    color: LoginContainerColors.containerShadowGrey,
    blurRadius: 4,
    spreadRadius: 2,
    offset: Offset(
      5,
      5,
    ),
  );

  static final BorderRadius containerBorderRadius = BorderRadius.all(
    Radius.circular(
      15,
    ),
  );

  static final BorderRadius infiniteCircularBorderRadius = BorderRadius.all(
    Radius.circular(
      1000,
    ),
  );

  static const double raisedButtonElevation = 5;
}

