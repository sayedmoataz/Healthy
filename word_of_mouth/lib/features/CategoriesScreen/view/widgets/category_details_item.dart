import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class CategoryDetailsItem extends StatelessWidget {
  final String imagePath;
  final String categoryName;
  final String categoryDescripation;
  final int priceAfter;
  final int priceBefore;
  final String productId;

  final VoidCallback? onTap;

  const CategoryDetailsItem({
    required this.imagePath,
    required this.categoryName,
    required this.categoryDescripation,
    required this.priceAfter,
    required this.priceBefore,
    required this.productId,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300),
            color: AppColors.whiteColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart_outlined,
                                size: 22.sp, color: Colors.black54),
                            onPressed: () {
                              // onTap!();
                              // ProductScreenController controller = Get.put(
                              //     ProductScreenController(
                              //         productId: productId,
                              //         collectionName: 'allProducts'));
                              // controller.addToCart(
                              //     productId: productId,
                              //     productName: categoryName,
                              //     price: priceAfter.toDouble(),
                              //     image: imagePath,
                              //     quantity: 1);
                            },
                          ),
                          Text(
                            categoryName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        categoryDescripation,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${priceAfter.toStringAsFixed(2)} EGP',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.successColor,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '${priceBefore.toStringAsFixed(2)} EGP',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
                child: Image.network(
                  imagePath,
                  height: 60.h,
                  width: 60.w,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
