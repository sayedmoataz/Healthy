import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';
import '../constants.dart';

AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: AppColors.whiteColor,
  elevation: 0,
  iconTheme: const IconThemeData(color: AppColors.blackColor),
  titleTextStyle: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  ),
);

AppBarTheme appBarDarkTheme = AppBarTheme(
  backgroundColor: AppColors.blackColor,
  elevation: 0,
  iconTheme: IconThemeData(color: AppColors.whiteColor),
  titleTextStyle: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColor,
  ),
);

ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
  trackColor: WidgetStateProperty.all(AppColors.primaryColor),
);

DataTableThemeData dataTableLightThemeData = DataTableThemeData(
  columnSpacing: 24.w,
  headingRowColor: WidgetStateProperty.all(AppColors.blackColor12),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
    border: Border.all(color: AppColors.blackColor12),
  ),
  dataTextStyle: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  ),
);

DataTableThemeData dataTableDarkThemeData = DataTableThemeData(
  columnSpacing: 24.w,
  headingRowColor: WidgetStateProperty.all(AppColors.whileColor12),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
    border: Border.all(color: AppColors.whileColor12),
  ),
  dataTextStyle: TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColor,
    fontSize: 12.sp,
  ),
);
