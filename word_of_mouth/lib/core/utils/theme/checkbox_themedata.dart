import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../constants.dart';

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  checkColor: WidgetStateProperty.all(AppColors.whiteColor),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(AppConstants.defaultBorderRadious / 2),
    ),
  ),
  side: const BorderSide(color: AppColors.whileColor40),
);
