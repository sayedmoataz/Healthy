import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_snack_bar.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/routing/app_routes.dart';

class ProductScreenController extends GetxController {
  final String productId;
  final String collectionName;

  ProductScreenController({
    required this.productId,
    required this.collectionName,
  });

  var isLoading = true.obs;
  var isAddingToCart = false.obs;
  var product = <String, dynamic>{}.obs;
  var relatedProducts = <Map<String, dynamic>>[].obs;
  var quantity = 1.obs;
  var selectedSize = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void selectQuantity(int qty) {
    quantity.value = qty;
  }

  void increment() {
    if (quantity.value < 3) {
      quantity.value++;
    }
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  Future<void> fetchProduct() async {
    try {
      isLoading.value = true;

      var referenceDoc = await FirebaseFirestore.instance
          .collection('globalData')
          .doc(collectionName)
          .collection('items')
          .doc(productId)
          .get();

      log('Reference document is: ${referenceDoc.data()}');

      if (referenceDoc.exists &&
          referenceDoc.data()!.containsKey('productRef')) {
        // is this product has a related products?
        // code of fetching related products
        DocumentReference productRef = referenceDoc.data()!['productRef'];

        var actualProductSnapshot = await productRef.get();

        if (actualProductSnapshot.exists) {
          product.value = {
            'id': actualProductSnapshot.id,
            ...actualProductSnapshot.data() as Map<String, dynamic>
          };
          log('Resolved product data: ${product.value}');
          fetchRelatedProducts();
        } else {
          product.value = {};
          log('Referenced product does not exist');
        }
      } else {
        // code of fetch this product as it is already exists
        product.value = referenceDoc.data() as Map<String, dynamic>;
        if (product.value.containsKey('relatedProducts')) {
          fetchRelatedProducts();
        } else {
          log('Product does not have related products');
        }
        log('Reference document does not contain a product reference');
      }
    } catch (e) {
      log('Error fetching product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRelatedProducts() async {
    try {
      // Check if the product has related products defined
      if (product.value.containsKey('relatedProducts')) {
        var relatedProductsMap =
            product.value['relatedProducts'] as Map<String, dynamic>;
        List<Map<String, dynamic>> resolvedProducts = [];

        // Process each related product
        for (var entry in relatedProductsMap.entries) {
          if (entry.value is Map && entry.value.containsKey('productRef')) {
            DocumentReference relatedProductRef = entry.value['productRef'];
            var relatedProductSnapshot = await relatedProductRef.get();

            if (relatedProductSnapshot.exists) {
              resolvedProducts.add({
                'id': relatedProductSnapshot.id,
                ...relatedProductSnapshot.data() as Map<String, dynamic>
              });
            }
          }
        }

        relatedProducts.value = resolvedProducts;
      } else {
        relatedProducts.value = [];
      }
    } catch (e) {
      log('Error fetching related products: $e');
    }
  }

  Future<void> loadProductDetails(
      String relatedProduct, String collectionName) async {
    try {
      isLoading.value = true;
      var referenceDoc = await FirebaseFirestore.instance
          .collection('globalData')
          .doc(collectionName)
          .collection('items')
          .doc(productId)
          .get();
      log('loadProductDetails Reference document is: ${referenceDoc.data()}');
      product.value = referenceDoc.data() as Map<String, dynamic>;
    } catch (e) {
      log('Error fetching product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart({
    required String productId,
    required String productName,
    required double price,
    required int quantity,
    required String image,
    String? size,
  }) async {
    try {
      isAddingToCart.value = true;
      
      CollectionReference cartCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(CacheHelper.getData(key: AppConstants.userId))
          .collection('cart');
      DocumentReference cartDocRef = cartCollection.doc('info');

      DocumentSnapshot cartSnapshot = await cartDocRef.get();

      Map<String, dynamic> cartData = cartSnapshot.exists
          ? cartSnapshot.data() as Map<String, dynamic>
          : {};

      Map<String, dynamic> products = cartData['products'] ?? {};

      String cartItemKey = size != null ? '$productId-$size' : productId;

      if (products.containsKey(cartItemKey)) {
        int currentQuantity = products[cartItemKey]['quantity'];
        products[cartItemKey]['quantity'] = currentQuantity + quantity;
        products[cartItemKey]['itemTotal'] = price * (currentQuantity + quantity);
        products[cartItemKey]['updatedAt'] = DateTime.now().toIso8601String();
      } else {
        products[cartItemKey] = {
          'productId': productId,
          'productName': productName,
          'price': price,
          'quantity': quantity,
          'image': image,
          'size': size,
          'itemTotal': price * quantity,
          'addedAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        };
      }

      await cartDocRef.set({'products': products}, SetOptions(merge: true));
      await _updateCartTotals(CacheHelper.getData(key: AppConstants.userId));

      log('✅ Item added to cart successfully!');
    } catch (e) {
      log('❌ Error adding item to cart: ${e.toString()}');
      CommonUI.showSnackBar('Failed to add item to cart.');
      rethrow;
    } finally {
      isAddingToCart.value = false;
    }
  }

  Future<void> _updateCartTotals(String userId) async {
    try {
      CollectionReference cartCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart');
      DocumentReference cartDocRef = cartCollection.doc('info');

      DocumentSnapshot cartSnapshot = await cartDocRef.get();

      if (!cartSnapshot.exists) return;

      Map<String, dynamic> cartData =
          cartSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> products = cartData['products'] ?? {};

      int totalItems = 0;
      double subtotal = 0.0;

      products.forEach((key, item) {
        totalItems += item['quantity'] as int;
        subtotal += item['itemTotal'] as double;
      });

      double tax = subtotal * 0.05;
      double total = subtotal + tax;

      await cartDocRef.update({
        'totalItems': totalItems,
        'subtotal': subtotal,
        'tax': tax,
        'total': total,
        'lastUpdated': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      log('❌ Error updating cart totals: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> handleAddToCart(Map<String, dynamic> product) async {
    if (product['sizes'] != null && selectedSize.value.isEmpty) {
      CommonUI.showSnackBar('الرجاء اختيار المقاس');
      return;
    }

    await addToCart(
      productId: productId,
      productName: product['name'],
      price: (product['priceAfter'] as num?)?.toDouble() ?? 0,
      quantity: quantity.value,
      size: selectedSize.value,
      image: product['images'] != null && product['images'].isNotEmpty
          ? product['images'][0]
          : AppAssets.networkImage,
    );

    Get.dialog(
      AlertDialog(
        title: const Text('تمت الإضافة للسلة'),
        content: const Text('هل تريد الاستمرار في التسوق أم الذهاب إلى السلة؟'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('متابعة التسوق'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.toNamed(AppRoutes.cartScreen);
            },
            child: const Text('الذهاب للسلة'),
          ),
        ],
      ),
    );
  }

}
