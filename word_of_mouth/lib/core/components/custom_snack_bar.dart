import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CommonUI {
  static void showSnackBar(String title) {
    Get.rawSnackbar(
      backgroundColor: AppColors.purpleColor,
      borderRadius: AppConstants.defaultBorderRadious,
      messageText: Text(
        title,
        style: TextStyle(fontSize: 15.sp, color: AppColors.whiteColor),
      ),
      forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
      reverseAnimationCurve: Curves.fastLinearToSlowEaseIn,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      duration: AppConstants.defaultDuration,
    );
  }
}
