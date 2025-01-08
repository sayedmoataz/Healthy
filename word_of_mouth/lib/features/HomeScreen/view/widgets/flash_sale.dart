import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/Banner/M/banner_m_with_counter.dart';
import '../../../../core/components/products/product_card.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../models/product_model.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BannerMWithCounter(
          duration: const Duration(hours: 8),
          image: AppAssets.networkImage,
          text: AppStrings.saleQuote,
          press: () {},
        ),
        const SizedBox(height: AppConstants.defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Text(
            AppStrings.flashSale,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(
          height: 170.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: demoFlashSaleProducts.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: AppConstants.defaultPadding,
                right: index == demoFlashSaleProducts.length - 1
                  ? AppConstants.defaultPadding : 0,
              ),
              child: ProductCard(
                image: demoFlashSaleProducts[index].image,
                title: demoFlashSaleProducts[index].title,
                price: demoFlashSaleProducts[index].price,
                priceAfetDiscount:demoFlashSaleProducts[index].priceAfetDiscount,
                dicountpercent: demoFlashSaleProducts[index].dicountpercent,
                press: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
