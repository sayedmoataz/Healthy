import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_snack_bar.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants.dart';
import '../models/order_model.dart';

class AllOrdersScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<OrderModel> orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
  try {
    String userId = CacheHelper.getData(key: AppConstants.userId);

    QuerySnapshot orderSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('orderDate', descending: true)
        .get();

    List<OrderModel> fetchedOrders = orderSnapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    orders.assignAll(fetchedOrders);
  } catch (e) {
    log('❌ Error fetching orders: ${e.toString()}');
    CommonUI.showSnackBar('Failed to fetch orders.');
  }
}

}
