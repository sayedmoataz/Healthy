import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var isFeaturedLoading = true.obs;
  var isPopularLoading = true.obs;
  var isFlashLoading = true.obs;
  var isSuperFlashLoading = true.obs;
  var isNewArrivalLoading = true.obs;
  var featuredProducts = <Map<String, dynamic>>[].obs;
  var popularProducts = <Map<String, dynamic>>[].obs;
  var flashSaleProducts = <Map<String, dynamic>>[].obs;
  var superFlashSaleProducts = <Map<String, dynamic>>[].obs;
  var superFlashSaleDuration = const Duration().obs;
  var newArrivalsProducts = <Map<String, dynamic>>[].obs;

Future<void> refreshAllData() async {
  isFeaturedLoading = true.obs;
  isPopularLoading = true.obs;
  isFlashLoading = true.obs;
  isSuperFlashLoading = true.obs;
  isNewArrivalLoading = true.obs;
  
  featuredProducts.clear();
  popularProducts.clear();
  flashSaleProducts.clear();
  superFlashSaleProducts.clear();
  newArrivalsProducts.clear();
  
  await Future.wait([
    fetchFeaturedProducts(),
    fetchPopularProducts(),
    fetchFlashSaleProducts(),
    fetchSuperFlashSaleProducts(),
    fetchNewArrivalProducts(),
  ]);
}

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts();
    fetchPopularProducts();
    fetchFlashSaleProducts();
    fetchSuperFlashSaleProducts();
    fetchNewArrivalProducts();
  }

  Future<void> fetchFeaturedProducts() async {
  try {
    isFeaturedLoading.value = true;

    var featuredProductsSnapshot = await FirebaseFirestore.instance
        .collection('globalData')
        .doc('featuredProducts')
        .collection('items')
        .get();
    
    // Log the number of documents
    log('Featured products documents count: ${featuredProductsSnapshot.docs.length}');
    
    // Log each document ID
    for (var doc in featuredProductsSnapshot.docs) {
      log('Document ID: ${doc.id}');
      
      var productRef = doc['productRef'] as DocumentReference;
      log('Product reference path: ${productRef.path}');
      
      var productSnapshot = await productRef.get();
      log('Product exists: ${productSnapshot.exists}');
      
      if (productSnapshot.exists) {
        featuredProducts.add({
          'id': productSnapshot.id,
          ...productSnapshot.data() as Map<String, dynamic>,
        });
      }
    }
    
    log('Final featured products count: ${featuredProducts.length}');
  } catch (e) {
    log('Error fetching featured products: $e');
  } finally {
    isFeaturedLoading.value = false;
  }
}

  Future<void> fetchPopularProducts() async {
    try {
      isPopularLoading.value = true;

      var popularProductsSnapshot = await FirebaseFirestore.instance
          .collection('globalData')
          .doc('popularProducts')
          .collection('items')
          .get();

      for (var doc in popularProductsSnapshot.docs) {
        var productRef = doc['productRef'] as DocumentReference;
        var productSnapshot = await productRef.get();
        if (productSnapshot.exists) {
          popularProducts.add({
            'id': productSnapshot.id,
            ...productSnapshot.data() as Map<String, dynamic>,
          });
        }
      }
    } catch (e) {
      log('Error fetching popular products: $e');
    } finally {
      isPopularLoading.value = false;
    }
  }

  Future<void> fetchFlashSaleProducts() async {
    try {
      isFlashLoading.value = true;

      var flashSaleProductsSnapshot = await FirebaseFirestore.instance
          .collection('globalData')
          .doc('flashSaleProducts')
          .collection('items')
          .get();

      for (var doc in flashSaleProductsSnapshot.docs) {
        var productRef = doc['productRef'] as DocumentReference;
        var productSnapshot = await productRef.get();
        if (productSnapshot.exists) {
          flashSaleProducts.add({
            'id': productSnapshot.id,
            ...productSnapshot.data() as Map<String, dynamic>,
          });
        }
      }
    } catch (e) {
      log('Error fetching flash sale products: $e');
    } finally {
      isFlashLoading.value = false;
    }
  }

  Future<void> fetchSuperFlashSaleProducts() async {
    try {
      isSuperFlashLoading.value = true;

      var superFlashSaleSnapshot = await FirebaseFirestore.instance
          .collection('globalData')
          .doc('superFlashSaleProducts')
          .collection('items')
          .get();

      for (var doc in superFlashSaleSnapshot.docs) {
        var productRef = doc['productRef'] as DocumentReference;
        var productSnapshot = await productRef.get();
        if (productSnapshot.exists) {
          var productData = productSnapshot.data() as Map<String, dynamic>;
          superFlashSaleProducts.add({
            'id': productSnapshot.id,
            ...productData,
          });

          if (productData['timerOfSuperFlash'] != null) {
            DateTime endTime = DateTime.parse(productData['timerOfSuperFlash']);
            DateTime now = DateTime.now();
            if (endTime.isAfter(now)) {
              superFlashSaleDuration.value = endTime.difference(now);
              log('superFlashSaleDuration.value is: ${superFlashSaleDuration.value}');
            } else {
              superFlashSaleDuration.value = const Duration();
            }
          }
        }
      }
    } catch (e) {
      log('Error fetching super flash sale products: $e');
    } finally {
      isSuperFlashLoading.value = false;
    }
  }

  Future<void> fetchNewArrivalProducts() async {
    try {
      isNewArrivalLoading.value = true;

      var newArrivalProductsSnapshot = await FirebaseFirestore.instance
          .collection('globalData')
          .doc('newArrivalProducts')
          .collection('items')
          .get();

      for (var doc in newArrivalProductsSnapshot.docs) {
        var productRef = doc['productRef'] as DocumentReference;
        var productSnapshot = await productRef.get();
        if (productSnapshot.exists) {
          newArrivalsProducts.add({
            'id': productSnapshot.id,
            ...productSnapshot.data() as Map<String, dynamic>,
          });
        }
      }
    } catch (e) {
      log('Error fetching featured products: $e');
    } finally {
      isNewArrivalLoading.value = false;
    }
  }
}
