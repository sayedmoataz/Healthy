import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryDetailsController extends GetxController {
  final String categoryId;

  CategoryDetailsController({required this.categoryId});

  var isLoading = true.obs;
  var products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      var productsSnapshot = await FirebaseFirestore.instance
          .collection('globalData')
          .doc('categories')
          .collection('items')
          .doc(categoryId)
          .collection('products')
          .get();

      products.value = productsSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
    } catch (e) {
      log('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }
}