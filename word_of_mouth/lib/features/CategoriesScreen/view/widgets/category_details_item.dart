import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';

class CategoryDetailsItem extends StatelessWidget {
  final String imagePath;
  final String categoryName;
  final String categoryDesc;
  final void Function()? onTap;
  const CategoryDetailsItem(
      {required this.imagePath,
      required this.categoryName,
      required this.categoryDesc,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding / 2),
      child: InkWell(
        splashColor: AppColors.transparentColor,
        onTap: onTap,
        child: Container(
          height: 80.h,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      categoryName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontFamily: AppStrings.grandisExtendedFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      categoryDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontFamily: AppStrings.grandisExtendedFont,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
