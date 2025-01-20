import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';

class AllOrdersScreenController extends GetxController {
  List<String> statuses = ['Pending', 'Accepted', 'Preparing', 'Out for Delivery', 'Delivered', 'Cancelled'];
List<String> dates = ['01/01/2023', '02/01/2023', '03/01/2023', '04/01/2023', '05/01/2023', '06/01/2023'];
List<int> orderIds = [123456, 123457, 123458, 123459, 123460, 123461];
List<Color> colors = [
  AppColors.purpleColor,
  AppColors.successColor,
  AppColors.warningColor,
  AppColors.warningColor,
  AppColors.successColor,
  AppColors.errorColor
];
}