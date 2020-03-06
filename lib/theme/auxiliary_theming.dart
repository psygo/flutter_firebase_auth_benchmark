import 'package:flutter/material.dart';

import 'colors.dart';

final BoxShadow containerBoxShadow = BoxShadow(
  color: containerShadowGrey,
  blurRadius: 4,
  spreadRadius: 2,
  offset: Offset(
    5,
    5,
  ),
);

final BorderRadius containerBorderRadius = BorderRadius.all(
  Radius.circular(
    15,
  ),
);

final BorderRadius infiniteCircularBorderRadius = BorderRadius.all(
  Radius.circular(
    1000,
  ),
);
