import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductScreenController extends GetxController {
  final String productId;
  final String collectionName;

  ProductScreenController({
    required this.productId,
    required this.collectionName,
  });

  var isLoading = true.obs;
  var product = <String, dynamic>{}.obs;
  var relatedProducts = <Map<String, dynamic>>[].obs;
  var quantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  void increment() => quantity.value++;
  void decrement() => quantity.value--;

  Future<void> fetchProduct() async {
    try {
      isLoading.value = true;

      var productSnapshot = await FirebaseFirestore.instance
          .collection('globalData')
          .doc(collectionName) // 'categories'
          .collection('items')
          .doc('electronics') // Missing step: specify category
          .collection('products')
          .doc(productId) // 'KWE3lVH8Qwz0WaItewR5'
          .get();
      log('Product data: ${productSnapshot.data()}');
      log('productSnapshot: ${productSnapshot.data()}');
      if (productSnapshot.exists) {
        product.value = productSnapshot.data()!;
        fetchRelatedProducts();
      } else {
        product.value = {};
      }
    } catch (e) {
      log('Error fetching product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRelatedProducts() async {
    try {
      var relatedProductsSnapshot = await FirebaseFirestore.instance
          .collection('globalData')
          .doc(collectionName)
          .collection('items')
          .doc('electronics')
          .collection('products')
          .doc(productId)
          .collection('relatedProducts')
          .get();

      log('Related Products: ${relatedProductsSnapshot.docs.map((e) => e.data())}');

      relatedProducts.value = relatedProductsSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
    } catch (e) {
      log('Error fetching related products: $e');
    }
  }
}
