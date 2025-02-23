import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../CartScreen/controllers/CartScreen_controller.dart';
import '../../../CartScreen/models/cart_model.dart';

class QuantitySelector extends StatelessWidget {
  final CartModel item;

  const QuantitySelector({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartScreenController controller = Get.put(CartScreenController());
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: item.quantity.value > 1
                  ? const Icon(Icons.remove)
                  : const Icon(Icons.delete, color: AppColors.errorColor),
              onPressed: item.quantity.value > 1
                  ? () =>
                      controller.updateQuantity(item, item.quantity.value - 1)
                  : () => controller.removeFromCart(productId: item.id),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding / 2,
                vertical: AppConstants.defaultPadding / 4,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '${item.quantity.value}',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: item.quantity.value < 10
                  ? () =>
                      controller.updateQuantity(item, item.quantity.value + 1)
                  : null,
            ),
          ],
        ));
  }
}
