import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../Product_screen/view/widgets/quantity_selector.dart';
import '../../models/cart_model.dart';

class CartItem extends StatelessWidget {
  CartModel item;
  CartItem({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding / 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(AppConstants.defaultBorderRadious),
          border: Border.all(color: AppColors.greyColor),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultBorderRadious),
              child: Image.network(
                item.image,
                width: 80.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      color: AppColors.darkGreyColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.descripation ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${item.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.priceColors,
                        ),
                      ),
                      if (item.priceAfterDiscount != null) ...[
                        SizedBox(width: 8.w),
                        Text(
                          '\$${item.priceAfterDiscount}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            QuantitySelector(item: item),
          ],
        ),
      ),
    );
  }
}
