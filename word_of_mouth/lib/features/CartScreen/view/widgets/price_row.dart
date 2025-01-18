import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class PriceRow extends StatelessWidget {
  final String title;
  final int? price;
  const PriceRow({
    required this.title,
    this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14.sp),
        ),
        if (price == null || price == 0) ...{
          const Text(
            'FREE',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.successColor),
          )
        } else ...{
          Text(
            '$price EGP',
            style: TextStyle(fontSize: 14.sp),
          )
        }
      ],
    );
  }
}
