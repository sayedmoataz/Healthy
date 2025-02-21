import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../controllers/CartScreen_controller.dart';
import '../widgets/cart_item.dart';
import '../widgets/coupon_field.dart';
import '../widgets/price_row.dart';

class CartScreenPage extends GetView<CartScreenController> {
  const CartScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: AppStrings.cart, backable: true),
            Text(
              AppStrings.reviewOrder,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 250.h,
              child: Obx(() {
                if (controller.cartItems.isEmpty) {
                  return const Center(child: Text('Your cart is empty'));
                }
                return ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.cartItems[index];
                    return CartItem(item: item);
                  },
                );
              }),
            ),
            CouponField(couponController: controller.couponController),
            Text(
              AppStrings.orderSummary,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(() => PriceRow(
                title: AppStrings.subTotal,
                price: controller.subtotal.value.toInt())),
            SizedBox(height: 8.h),
            const PriceRow(title: AppStrings.shippingFee, price: 0),
            SizedBox(height: 8.h),
            Obx(() => PriceRow(
                title: AppStrings.totalPrice,
                price: controller.total.value.toInt())),
            SizedBox(height: 8.h),
            Obx(() => PriceRow(
                title: AppStrings.estimatedVAT,
                price: controller.tax.value.toInt())),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.createOrder(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMaterialColor,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.defaultPadding),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        AppConstants.defaultBorderRadious),
                  ),
                ),
                child: Text(
                  AppStrings.checkout,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
