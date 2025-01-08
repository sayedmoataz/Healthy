import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../constants.dart';

InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  fillColor: AppColors.lightGreyColor,
  filled: true,
  hintStyle: const TextStyle(color: AppColors.greyColor),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
);

InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  fillColor: AppColors.darkGreyColor,
  filled: true,
  hintStyle: const TextStyle(color: AppColors.whileColor40),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius:
      BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
  borderSide: const BorderSide(
    color: AppColors.transparentColor,
  ),
);

OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
  borderRadius:
      BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
  borderSide: const BorderSide(color: AppColors.primaryColor),
);

OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
  borderRadius:
      BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
  borderSide: const BorderSide(
    color: AppColors.errorColor,
  ),
);

OutlineInputBorder secodaryOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius:
        BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
    borderSide: BorderSide(
      color:
          Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.15),
    ),
  );
}
