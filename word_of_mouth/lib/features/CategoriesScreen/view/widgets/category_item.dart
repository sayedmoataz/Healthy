import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String categoryName;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.imagePath,
    required this.categoryName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
        child: Container(
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(AppConstants.defaultBorderRadious),
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultBorderRadious),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.blackColor.withValues(alpha: 0.3),
                  AppColors.blackColor.withValues(alpha: 0.5),
                ],
              ),
            ),
            child: Center(
              child: TextButton(
                onPressed: onTap,
                child: Text(
                  categoryName,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontFamily: AppStrings.grandisExtendedFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                    letterSpacing: 2.0.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
