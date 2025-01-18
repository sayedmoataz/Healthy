import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData? icon;
  const CustomAppBar({ 
    required this.title,
    this.icon,
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
          if(icon != null )...{
            IconButton(
            icon: Icon(icon, color: AppColors.blackColor),
            onPressed: () {},
          ),
          }
        ],
      ),
    );
  }
}
