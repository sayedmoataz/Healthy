import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';

class CouponField extends StatelessWidget {
  TextEditingController couponController;
  CouponField({required this.couponController ,super.key});

  @override
  Widget build(ontext) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadious),
      ),
      child: Row(
        children: [
          const Icon(Icons.confirmation_number_outlined),
          const SizedBox(width: AppConstants.defaultPadding/2),
          Expanded(
            child: TextField(
              controller: couponController,
              decoration: const InputDecoration(
                enabled: false,
                border: InputBorder.none,
                hintText: AppStrings.couponCode,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
