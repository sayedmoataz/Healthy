import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../controller/AllOrdersScreen_controller.dart';

class AllOrdersScreenPage extends StatelessWidget {
  const AllOrdersScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllOrdersScreenController controller =
        Get.put(AllOrdersScreenController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: AppStrings.orders, backable: false),
            const SizedBox(height: AppConstants.defaultPadding),
            Expanded(
              child: Obx(() {
                if (controller.orders.isEmpty) {
                  return const Center(
                    child:
                        Text('No orders found', style: TextStyle(fontSize: 16)),
                  );
                }

                return ListView.builder(
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    final order = controller.orders[index];

                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppConstants.defaultPadding,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(
                            AppConstants.defaultBorderRadious,
                          ),
                          border: Border.all(color: AppColors.greyColor),
                        ),
                        child: ListTile(
                          title: Text('Order ID: ${order.orderId}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order Date: ${order.orderDate}'),
                              Text(
                                  'Total: \$${order.total.toStringAsFixed(2)}'),
                              // const Text('Items: {order.itemCount}'),
                            ],
                          ),
                          trailing: Text(
                            order.status,
                            style: TextStyle(
                              color: getStatusColor(order.status),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: getStatusColor(order.status),
                            child: Icon(Icons.shopping_cart,
                                color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get status color
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.purpleColor;
      case 'accepted':
        return AppColors.successColor;
      case 'preparing':
        return AppColors.warningColor;
      case 'out for delivery':
        return AppColors.warningColor;
      case 'delivered':
        return AppColors.successColor;
      case 'cancelled':
        return AppColors.errorColor;
      default:
        return AppColors.greyColor;
    }
  }
}
