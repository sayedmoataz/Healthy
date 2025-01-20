import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../controller/AllOrdersScreen_controller.dart';

class AllOrdersScreenPage extends GetView<AllOrdersScreenController> {
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
            child: ListView.builder(
              itemCount: controller.statuses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: AppConstants.defaultPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(
                          AppConstants.defaultBorderRadious),
                      border: Border.all(color: AppColors.greyColor),
                    ),
                    child: ListTile(
                      title: Text('Order ID: ${controller.orderIds[index]}'),
                      subtitle:
                          Text('Order Date: ${controller.dates[index]}'),
                      trailing: Text(
                        controller.statuses[index],
                        style: TextStyle(
                            color: controller.colors[index],
                            fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: controller.colors[index],
                        child: Icon(
                          Icons.person,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
