import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';


ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: AppStrings.appFont,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  );
}