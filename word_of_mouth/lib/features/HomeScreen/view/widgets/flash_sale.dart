import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/Banner/M/banner_m_with_counter.dart';
import '../../../../core/components/products/product_card.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../controllers/HomeScreen_controller.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // // Super Flash Sale (only one product)
        // Obx(() {
        //   if (controller.isSuperFlashLoading.value) {
        //     return const Center(child: CircularProgressIndicator());
        //   }
        //   if (controller.superFlashSaleProducts.isEmpty) {
        //     return const Center(child: Text('No super flash sale products found'));
        //   }
        //   var superFlashSaleProduct = controller.superFlashSaleProducts[0];
        //   return BannerMWithCounter(
        //     duration: controller.superFlashSaleDuration.value, // Time to finish from now
        //     image: superFlashSaleProduct['images'][0], // Image of the product
        //     text: AppStrings.saleQuote, // Static text
        //     press: () {
        //       Get.toNamed(
        //         AppRoutes.productScreen,
        //         arguments: {
        //           'productId': superFlashSaleProduct['id'],
        //           'collectionName': 'superFlashSaleProducts',
        //         },
        //       );
        //     },
        //   );
        // }),
        // const SizedBox(height: AppConstants.defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Text(
            AppStrings.flashSale,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // Flash Sale
        Obx(() {
          if (controller.isFlashLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.flashSaleProducts.isEmpty) {
            return const Center(child: Text('No flash sale products found'));
          }

          return SizedBox(
            height: 170.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.flashSaleProducts.length,
              itemBuilder: (context, index) {
                var product = controller.flashSaleProducts[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: AppConstants.defaultPadding,
                    right: index == controller.flashSaleProducts.length - 1
                        ? AppConstants.defaultPadding
                        : 0,
                  ),
                  child: ProductCard(
                    image: product['images'][0],
                    title: product['name'],
                    price: product['priceBefore'],
                    priceAfetDiscount: product['priceAfter'],
                    dicountpercent: product['discount'],
                    press: () {
                      Get.toNamed(
                        AppRoutes.productScreen,
                        arguments: {
                          'productId': product['id'],
                          'collectionName': 'flashSaleProducts',
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
