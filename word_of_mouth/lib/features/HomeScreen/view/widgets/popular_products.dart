import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/products/product_card.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../controllers/HomeScreen_controller.dart';


class PopularProducts extends StatelessWidget {
  const PopularProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppConstants.defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Text(
            AppStrings.popularCategories,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Obx(() {
          if (controller.isPopularLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.popularProducts.isEmpty) {
            return const Center(child: Text('No popular products found'));
          }

          return SizedBox(
            height: 150.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.popularProducts.length,
              itemBuilder: (context, index) {
                var product = controller.popularProducts[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: AppConstants.defaultPadding,
                    right: index == controller.popularProducts.length - 1
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
                          'collectionName': 'popularProducts',
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