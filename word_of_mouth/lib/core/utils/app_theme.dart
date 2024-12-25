import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: AppStrings.appFont,
  );
}