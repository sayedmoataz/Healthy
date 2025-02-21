import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/constants.dart';
import '../network_image_loader.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
    required this.press,
  });
  final String image, title;
  final int? price;
  final int? priceAfetDiscount;
  final int? dicountpercent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(140, 220),
        maximumSize: const Size(140, 220),
        padding: const EdgeInsets.all(8),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(src: image, radius: AppConstants.defaultBorderRadious),
                if (dicountpercent != null)
                  Positioned(
                    right: AppConstants.defaultPadding / 2,
                    top: AppConstants.defaultPadding / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding / 2),
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: AppColors.errorColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppConstants.defaultBorderRadious)),
                      ),
                      child: Text(
                        dicountpercent.toString() + AppStrings.off,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding / 2,
                vertical: AppConstants.defaultPadding / 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppConstants.defaultPadding / 2),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 10.sp),
                  ),
                  const Spacer(),
                  priceAfetDiscount != null 
                  ? Row(
                      children: [
                        Text(
                          '$priceAfetDiscount EGP',
                          style: TextStyle(
                            color: AppColors.priceColors,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                        const SizedBox(width: AppConstants.defaultPadding / 4),
                        Text(
                          '$price EGP',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                            fontSize: 8.sp,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    )
                  : Text(
                          '$price EGP',
                          style: TextStyle(
                            color: AppColors.priceColors,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
