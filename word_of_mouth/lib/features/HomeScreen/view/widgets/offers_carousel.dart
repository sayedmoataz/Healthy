import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../controllers/HomeScreen_controller.dart';

class OffersCarousel extends StatefulWidget {
  const OffersCarousel({super.key});

  @override
  State<OffersCarousel> createState() => _OffersCarouselState();
}

class _OffersCarouselState extends State<OffersCarousel> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());

    return Obx(() {
      if (controller.isFeaturedLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.featuredProducts.isEmpty) {
        return const Center(child: Text('No featured products found'));
      }

      return Padding(
        padding: EdgeInsets.only(top: 8.0.h),
        child: CarouselSlider.builder(
          itemCount: controller.featuredProducts.length,
          itemBuilder: (context, index, realIndex) {
            var product = controller.featuredProducts[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.productScreen,
                  arguments: {
                    'productId': product['id'],
                    'collectionName': 'featuredProducts',
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.priceColors,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Image.network(
                      product['images'][0],
                      fit: BoxFit.cover,
                      width: 100.w,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product['name'],
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            product['description'],
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 125.h,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.80,
            onPageChanged: (index, reason) =>
                setState(() => _currentIndex = index),
          ),
        ),
      );
    });
  }
}
