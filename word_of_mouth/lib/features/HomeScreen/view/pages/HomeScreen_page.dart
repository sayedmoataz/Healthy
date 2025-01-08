import 'package:flutter/material.dart';

import '../../../../core/components/Banner/S/banner_s_style_1.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../widgets/flash_sale.dart';
import '../widgets/offer_carousel_and_categories.dart';
import '../widgets/popular_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
            const SliverToBoxAdapter(child: PopularProducts()),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 1.5),
              sliver: SliverToBoxAdapter(child: FlashSale()),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  BannerSStyle1(
                    title: AppStrings.newArrival,
                    subtitle: AppStrings.specialOffer,
                    image: AppAssets.networkImage,
                    discountParcent: 50,
                    press: () {},
                  ),
                  const SizedBox(height: AppConstants.defaultPadding / 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
