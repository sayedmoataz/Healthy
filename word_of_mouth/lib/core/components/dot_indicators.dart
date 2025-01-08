import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.inActiveColor,
    this.activeColor = AppColors.primaryColor,
  });

  final bool isActive;
  final Color? inActiveColor, activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.defaultDuration,
      height: isActive ? 12.h : 4.h,
      width: 4.w,
      decoration: BoxDecoration(
        color: isActive
          ? activeColor
          : inActiveColor ?? AppColors.primaryMaterialColor.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(AppConstants.defaultPadding)),
      ),
    );
  }
}