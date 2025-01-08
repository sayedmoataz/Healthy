import 'package:flutter/material.dart';

import '../app_strings.dart';
import '../app_colors.dart';
import 'button_theme.dart';
import 'checkbox_themedata.dart';
import 'input_decoration_theme.dart';

ThemeData appTheme() {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: AppStrings.appPrimaryFont,
    primarySwatch: AppColors.primaryMaterialColor,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    iconTheme: const IconThemeData(color: AppColors.blackColor),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.blackColor40),
    ),
    elevatedButtonTheme: elevatedButtonThemeData,
    textButtonTheme: textButtonThemeData,
    outlinedButtonTheme: outlinedButtonTheme(),
    inputDecorationTheme: lightInputDecorationTheme,
    checkboxTheme: checkboxThemeData.copyWith(
      side: const BorderSide(color: AppColors.blackColor40),
    ),
  );
}