import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/Banner/M/banner_m_style.dart';
import '../../../../core/components/dot_indicators.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../controllers/HomeScreen_controller.dart';

class OffersCarousel extends StatefulWidget {
  const OffersCarousel({
    super.key,
  });

  @override
  State<OffersCarousel> createState() => _OffersCarouselState();
}

class _OffersCarouselState extends State<OffersCarousel> {
  int _selectedIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      final controller = Get.find<HomeScreenController>();
      if (_selectedIndex < controller.featuredProducts.length - 1) {
        _selectedIndex++;
      } else {
        _selectedIndex = 0;
      }

      _pageController.animateToPage(
        _selectedIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

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

      return AspectRatio(
        aspectRatio: 1.87,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: controller.featuredProducts.length,
              onPageChanged: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              itemBuilder: (context, index) {
                var product = controller.featuredProducts[index];
                return BannerMStyle4(
                  image: product['images'][0],
                  title: product['name'],
                  subtitle: product['description'],
                  discountParcent: product['discount'],
                  press: () {
                    Get.toNamed(
                      AppRoutes.productScreen,
                      arguments: {
                        'productId': product['id'],
                        'collectionName': 'featuredProducts',
                      },
                    );
                  },
                );
              },
            ),
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: SizedBox(
                  height: 16.h,
                  child: Row(
                    children: List.generate(
                      controller.featuredProducts.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: AppConstants.defaultPadding / 4),
                          child: DotIndicator(
                            isActive: index == _selectedIndex,
                            activeColor: Colors.white70,
                            inActiveColor: Colors.white54,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
