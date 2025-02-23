import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../controllers/HomeScreen_controller.dart';
import '../widgets/flash_sale.dart';
import '../widgets/offer_carousel_and_categories.dart';
import '../widgets/popular_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final controller = Get.put(HomeScreenController());
            controller.refreshAllData();
          },
          child: const CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: OffersCarouselAndCategories()),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                    vertical: AppConstants.defaultPadding * 1.5),
                sliver: SliverToBoxAdapter(child: FlashSale()),
              ),
              SliverToBoxAdapter(child: PopularProducts()),
              // SliverToBoxAdapter(
              //   child: Column(
              //     children: [
              //       BannerSStyle1(),
              //       const SizedBox(height: AppConstants.defaultPadding / 4),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
