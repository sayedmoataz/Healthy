import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/products/product_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../../../core/components/custom_app_bar.dart';
import '../../../HomeScreen/models/product_model.dart';
import '../../../HomeScreen/view/widgets/offers_carousel.dart';
import '../../controllers/Product_screen_controller.dart';
import '../widgets/quantity_selector.dart';

class ProductScreenPage extends GetView<ProductScreenController> {
  const ProductScreenPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(title: 'ProductName'),
            const OffersCarousel(),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Text(
                  'عصير برتقال طبيعي 250مل',
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
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Text(
                  AppStrings.producrDescripation,                  
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
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
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
            QuantitySelector(),
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding * .5),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(AppStrings.addToCart),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Text(
                  AppStrings.relatedProducts,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            SizedBox(
              height: 150.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: demoPopularProducts.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: AppConstants.defaultPadding,
                    right: index == demoPopularProducts.length - 1
                        ? AppConstants.defaultPadding
                        : 0,
                  ),
                  child: ProductCard(
                    image: demoPopularProducts[index].image,
                    title: demoPopularProducts[index].title,
                    price: demoPopularProducts[index].price,
                    priceAfetDiscount:
                        demoPopularProducts[index].priceAfetDiscount,
                    dicountpercent: demoPopularProducts[index].dicountpercent,
                    press: () {
                      Get.toNamed(AppRoutes.productScreen);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
