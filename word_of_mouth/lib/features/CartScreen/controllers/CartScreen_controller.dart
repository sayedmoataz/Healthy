import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_snack_bar.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/constants.dart';
import '../models/cart_model.dart';

class CartScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<CartModel> cartItems = <CartModel>[].obs;
  RxDouble subtotal = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble total = 0.0.obs;

  TextEditingController quantityController = TextEditingController();
  TextEditingController couponController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCartData();
  }

  var quantity = 1.obs;

  void increment() {
    if (quantity.value < 10) {
      quantity.value++;
    }
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  Future<void> updateQuantity(CartModel item, int newQuantity) async {
    if (newQuantity < 1 || newQuantity > 10) return;
    try {
      String userId = CacheHelper.getData(key: AppConstants.userId);
      double itemTotal = item.price * newQuantity;
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc('info')
          .update({
        'products.${item.id}.quantity': newQuantity,
        'products.${item.id}.itemTotal': itemTotal,
        'products.${item.id}.updatedAt': DateTime.now().toIso8601String(),
      });
      item.quantity.value = newQuantity;
      await _updateCartTotals(userId);
      await fetchCartData();
    } catch (e) {
      log('❌ Error updating quantity: ${e.toString()}');
      CommonUI.showSnackBar('Failed to update quantity.');
    }
  }

  Future<void> fetchCartData() async {
    try {
      // Null check for userId
      String? userId = CacheHelper.getData(key: AppConstants.userId);
      if (userId == null) {
        log('userId is null');
        _handleEmptyCart();
        return;
      }

      log('userId is: $userId');

      DocumentSnapshot cartSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc('info')
          .get();

      log('cartSnapshot is: $cartSnapshot');

      if (!cartSnapshot.exists) {
        log('cartSnapshot does not exist');
        _handleEmptyCart();
        return;
      }

      // Safely cast and handle potential null data
      Map<String, dynamic>? cartData =
          cartSnapshot.data() as Map<String, dynamic>?;
      if (cartData == null) {
        log('cartData is null');
        _handleEmptyCart();
        return;
      }

      Map<String, dynamic> products = cartData['products'] ?? {};
      List<CartModel> tempCartItems = [];

      products.forEach((key, item) {
        // Null safety for all fields
        tempCartItems.add(
          CartModel(
            id: item['productId']?.toString() ?? '',
            name: item['productName']?.toString() ?? '',
            image: item['image']?.toString() ?? AppAssets.networkImage,
            price: (item['price'] ?? 0.0).toDouble(),
            quantity: (item['quantity'] ?? 1).toInt(),
            priceAfterDiscount: item['priceAfterDiscount']?.toDouble(),
            descripation: item['descripation']?.toString(),
          ),
        );
      });

      cartItems.assignAll(tempCartItems);
      subtotal.value = (cartData['subtotal'] ?? 0.0).toDouble();
      tax.value = (cartData['tax'] ?? 0.0).toDouble();
      total.value = (cartData['total'] ?? 0.0).toDouble();
    } catch (e) {
      log('❌ Error fetching cart data: ${e.toString()}');
      CommonUI.showSnackBar('Failed to fetch cart data.');
    }
  }

  // Helper method to handle empty cart state
  void _handleEmptyCart() {
    cartItems.clear();
    subtotal.value = 0.0;
    tax.value = 0.0;
    total.value = 0.0;
  }

  Future<void> _updateCartTotals(String userId) async {
    try {
      DocumentSnapshot cartSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc('info')
          .get();

      if (!cartSnapshot.exists) return;

      Map<String, dynamic> cartData =
          cartSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> products = cartData['products'] ?? {};

      int totalItems = 0;
      double subtotal = 0.0;

      products.forEach((key, item) {
        int quantity = item['quantity'] as int;
        double price = item['price'] as double;
        double itemTotal = price * quantity;
        products[key]['itemTotal'] = itemTotal;

        totalItems += quantity;
        subtotal += itemTotal;
      });

      double tax = subtotal * 0.05;
      double total = subtotal + tax;

      // Update the full products map along with the totals
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc('info')
          .update({
        'products': products,
        'totalItems': totalItems,
        'subtotal': subtotal,
        'tax': tax,
        'total': total,
        'lastUpdated': DateTime.now().toIso8601String(),
      });

      // Update the reactive values
      this.subtotal.value = subtotal;
      this.tax.value = tax;
      this.total.value = total;
    } catch (e) {
      log('❌ Error updating cart totals: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> removeFromCart({
    required String productId,
  }) async {
    try {
      var userId = CacheHelper.getData(key: AppConstants.userId);
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc('info')
          .update({
        'products.$productId': FieldValue.delete(),
      });

      await _updateCartTotals(userId);
      await fetchCartData();

      log('✅ Item removed from cart successfully!');
    } catch (e) {
      log('❌ Error removing item from cart: ${e.toString()}');
      CommonUI.showSnackBar('Failed to remove item from cart.');
      rethrow;
    }
  }

  Future<String> createOrder() async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();
    final userId = CacheHelper.getData(key: AppConstants.userId);

    try {
      // Get user info
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Get cart items
      QuerySnapshot cartItems = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .where(FieldPath.documentId, isNotEqualTo: 'info')
          .get();

      // Get cart info
      DocumentSnapshot cartInfo = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc('info')
          .get();
      Map<String, dynamic> cartInfoData =
          cartInfo.data() as Map<String, dynamic>;

      // Prepare order items
      List<Map<String, dynamic>> orderItems = [];
      for (var doc in cartItems.docs) {
        Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
        orderItems.add({
          'productId': item['productId'],
          'productName': item['productName'],
          'price': item['price'],
          'quantity': item['quantity'],
          'itemTotal': item['itemTotal'],
          'image': item['image'],
        });
      }

      // Create order document
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .set({
        'orderId': orderId,
        'orderDate': DateTime.now().toIso8601String(),
        'status': 'pending',
        'items': orderItems,
        'subtotal': cartInfoData['subtotal'],
        'tax': cartInfoData['tax'],
        'total': cartInfoData['total'],
        'shippingAddress': userData['address'],
        'customerName': '${userData['firstName']} ${userData['lastName']}',
        'customerEmail': userData['email'],
        'customerPhone': userData['phone'],
        'paymentMethod': 'COD',
        'paymentStatus': 'pending',
        'trackingNumber': null,
        'estimatedDelivery': null,
      });

      // Update orders info document
      QuerySnapshot allOrders = await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .where(FieldPath.documentId, isNotEqualTo: 'info')
          .get();

      double totalSpent = 0.0;
      for (var doc in allOrders.docs) {
        Map<String, dynamic> order = doc.data() as Map<String, dynamic>;
        totalSpent += order['total'] as double;
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc('info')
          .update({
        'totalOrders': allOrders.docs.length,
        'lastOrderDate': DateTime.now().toIso8601String(),
        'totalSpent': totalSpent,
      });

      // Also create in global orders collection for admin access
      await _firestore.collection('orders').doc(orderId).set({
        'orderId': orderId,
        'userId': userId,
        'orderDate': DateTime.now().toIso8601String(),
        'status': 'pending',
        'total': cartInfoData['total'],
        'items': orderItems.length,
        'customerName': '${userData['firstName']} ${userData['lastName']}',
      });

      // Clear cart after order creation
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc('info')
          .update({
        'totalItems': 0,
        'subtotal': 0.0,
        'discount': 0.0,
        'tax': 0.0,
        'total': 0.0,
        'products': {}, // Clear the products map
        'lastUpdated': DateTime.now().toIso8601String(),
      });

      // Clear local cart data
      this.cartItems.clear();
      subtotal.value = 0.0;
      tax.value = 0.0;
      total.value = 0.0;

      // Show success message
      CommonUI.showSnackBar('Order placed successfully!');

      log('✅ Order created successfully: $orderId');
      return orderId;
    } catch (e) {
      log('❌ Error creating order: ${e.toString()}');
      CommonUI.showSnackBar('Failed to create order.');
      rethrow;
    }
  }
}
