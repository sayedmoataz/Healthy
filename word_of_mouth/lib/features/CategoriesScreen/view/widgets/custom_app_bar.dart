import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({ 
    required this.title,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
            onPressed: () => Get.back(),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.blackColor),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
