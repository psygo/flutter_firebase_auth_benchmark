import 'package:flutter/material.dart';

import 'colors.dart';

final BoxShadow containerBoxShadow = BoxShadow(
  color: containerShadowGrey,
  blurRadius: 6,
  spreadRadius: 3,
  offset: Offset(
    7,
    7,
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
