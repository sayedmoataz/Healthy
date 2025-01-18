import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/Product_screen_controller.dart';

class QuantitySelector extends StatelessWidget {
  final ProductScreenController controller = Get.put(ProductScreenController());

  QuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: controller.quantity > 1
                  ? controller.decrement
                  : null, // Disable if quantity is 1
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '${controller.quantity}',
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: controller.quantity < 10
                  ? controller.increment
                  : null, // Disable if quantity is 10
            ),
          ],
        ));
  }
}
