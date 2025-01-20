import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../pages/category_details.dart';

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String categoryName;
  const CategoryItem(
      {required this.imagePath, required this.categoryName, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const CategoryDetails());
      },
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
                  onPressed: () {},
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
              )),
        ),
      ),
    );
  }
}
