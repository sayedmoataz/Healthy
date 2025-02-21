import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../features/HomeScreen/controllers/HomeScreen_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/constants.dart';
import '../../../utils/routing/app_routes.dart';
import '../banner_discount_tag.dart';
import 'banner_s.dart';

class BannerSStyle1 extends StatelessWidget {
  const BannerSStyle1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Obx(() {
      if (controller.isNewArrivalLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.featuredProducts.isEmpty) {
        return const Center(child: Text('No New Arrivals products found'));
      }
      return BannerS(
        image: controller.newArrivalsProducts.first['images'][0],
        press: () {
          Get.toNamed(
            AppRoutes.productScreen,
            arguments: {
              'productId': controller.newArrivalsProducts.first['id'],
              'collectionName': 'newArrivalProducts',
            },
          );
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.newArrivalsProducts.first['name'],
                        style: TextStyle(
                          fontFamily: AppStrings.grandisExtendedFont,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColors.whiteColor,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: AppConstants.defaultPadding / 4),
                      if (controller.newArrivalsProducts.first['description'] != null)
                        Text(
                          controller.newArrivalsProducts.first['description'],
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: AppConstants.defaultPadding / 4),
            child: Align(
              alignment: Alignment.topRight,
              child: BannerDiscountTag(
                percentage: controller.newArrivalsProducts.first['discount'],
                height: 56.h,
              ),
            ),
          ),
        ],
      );
    });
  }
}
