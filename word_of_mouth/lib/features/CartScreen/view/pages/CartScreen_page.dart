import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../../InfoScreen/controllers/InfoScreen_controller.dart';
import '../../controllers/CartScreen_controller.dart';
import '../widgets/cart_item.dart';
import '../widgets/coupon_field.dart';
import '../widgets/price_row.dart';

class CartScreenPage extends GetView<CartScreenController> {
  const CartScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InfoScreenController authController = Get.put(InfoScreenController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.shippingInfo,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.editProfileScreen),
                      child: Text(
                        AppStrings.editProfile,
                        style: TextStyle(
                          color: AppColors.primaryMaterialColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    )
                  ],
                ),

                // Handle loading state for user data
                Obx(() {
                  if (authController.isEditLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserInfoRow(
                          icon: Icons.person,
                          text:
                              '${authController.firstNameController.text} ${authController.lastNameController.text}',
                        ),
                        UserInfoRow(
                          icon: Icons.location_on,
                          text:
                              '${authController.streetController.text}, ${authController.cityController.text}, ${authController.stateController.text}',
                        ),
                        UserInfoRow(
                          icon: Icons.mobile_friendly,
                          text: authController.phoneController.text.isEmpty
                              ? 'No phone number'
                              : authController.phoneController.text,
                        ),
                      ],
                    ),
                  );
                }),

                SizedBox(height: 20.h),
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

                SizedBox(height: 20.h),

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
                Obx(() => PriceRow(
                    title: AppStrings.estimatedVAT,
                    price: controller.tax.value.toInt())),
                SizedBox(height: 8.h),
                const PriceRow(title: AppStrings.shippingFee, price: 0),
                SizedBox(height: 8.h),
                const PriceRow(title: AppStrings.Discount, price: 0),
                SizedBox(height: 8.h),
                Obx(() => PriceRow(
                    title: AppStrings.totalPrice,
                    price: controller.total.value.toInt())),

                SizedBox(height: 20.h),

                Obx(() {
                  bool isButtonEnabled =
                      authController.isUserDataComplete.value &&
                          controller.cartItems.isNotEmpty;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () => controller.createOrder()
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isButtonEnabled
                            ? AppColors.primaryMaterialColor
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.defaultPadding),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppConstants.defaultBorderRadious),
                        ),
                      ),
                      child: Text(
                        authController.isUserDataComplete.value
                            ? AppStrings.checkout
                            : AppStrings.completeProfile,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Reusable User Info Row
class UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const UserInfoRow({required this.icon, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryMaterialColor),
        SizedBox(width: 10.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
