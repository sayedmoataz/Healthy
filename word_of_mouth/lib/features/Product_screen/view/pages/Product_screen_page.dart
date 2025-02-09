import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../HomeScreen/view/widgets/offers_carousel.dart';
import '../../controllers/Product_screen_controller.dart';
import '../widgets/quantity_selector.dart';

class ProductScreenPage extends GetView<ProductScreenController> {
  final String productId;
  final String collectionName;

  const ProductScreenPage({
    Key? key,
    required this.productId,
    required this.collectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(title: 'ProductName', backable: true),
              const OffersCarousel(),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                var product = controller.product;
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppConstants.defaultPadding),
                        child: Text(
                          product['name'] ?? 'No name available',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor80,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppConstants.defaultPadding),
                        child: Text(
                          product['description'] ?? 'No description available',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor60,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppConstants.defaultPadding),
                        child: Text(
                          'حدد عدد القطع الذي تريده للشحن',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const QuantitySelector(),
                    Padding(
                      padding: const EdgeInsets.all(
                          AppConstants.defaultPadding * .5),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(AppStrings.addToCart),
                      ),
                    ),
                    //! Related Products
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Padding(
                    //     padding:
                    //         const EdgeInsets.all(AppConstants.defaultPadding),
                    //     child: Text(
                    //       AppStrings.relatedProducts,
                    //       style: Theme.of(context).textTheme.titleMedium,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 150.h,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: controller.relatedProducts.length,
                    //     itemBuilder: (context, index) {
                    //       var relatedProduct =
                    //           controller.relatedProducts[index];
                    //       return Padding(
                    //         padding: EdgeInsets.only(
                    //           left: AppConstants.defaultPadding,
                    //           right:
                    //               index == controller.relatedProducts.length - 1
                    //                   ? AppConstants.defaultPadding
                    //                   : 0,
                    //         ),
                    //         child: ProductCard(
                    //           image: (relatedProduct['images'] != null &&
                    //                   relatedProduct['images'].isNotEmpty)
                    //               ? relatedProduct['images'][0]
                    //               : 'default_image_url',
                    //           title:
                    //               relatedProduct['name'] ?? 'Unknown Product',
                    //           price: (relatedProduct['priceBefore'] as num?)
                    //                   ?.toDouble() ??
                    //               0.0,
                    //           priceAfetDiscount:
                    //               (relatedProduct['priceAfter'] as num?)
                    //                   ?.toDouble(),
                    //           dicountpercent:
                    //               (relatedProduct['discount'] as num?)?.toInt(),
                    //           press: () {
                    //             log('productId is: ${relatedProduct['id']}');
                    //             log('collectionName is: $collectionName');
                    //             Get.offNamed(
                    //               AppRoutes.productScreen,
                    //               arguments: {
                    //                 'productId': relatedProduct['id'],
                    //                 'collectionName': collectionName,
                    //               },
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
