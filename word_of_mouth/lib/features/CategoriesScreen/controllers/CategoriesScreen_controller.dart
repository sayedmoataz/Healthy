import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  var searchQuery = ''.obs;
  var categories = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var products = <Map<String, dynamic>>[].obs;

  String? currentCategoryId;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    log('start fetching data');
    try {
      isLoading.value = true;

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await firestore
          .collection('globalData')
          .doc('categories')
          .collection('items')
          .get();

      categories.value = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
          'image': doc['image'],
        };
      }).toList();
    } catch (e) {
      log('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch products for a specific category
  Future<void> fetchProducts(String categoryId) async {
    try {
      isLoading.value = true;
      currentCategoryId = categoryId; // Set the current category ID

      // Fetch product references for the category
      var productsSnapshot = await FirebaseFirestore.instance
          .collection('globalData')
          .doc('categories')
          .collection('items')
          .doc(categoryId)
          .collection('products')
          .get();

      // Fetch actual product data from the 'allProducts' collection
      var productsList = <Map<String, dynamic>>[];
      for (var doc in productsSnapshot.docs) {
        var productRef = doc['productRef'] as DocumentReference;
        var productSnapshot = await productRef.get();

        if (productSnapshot.exists) {
          productsList.add({
            'id': productSnapshot.id,
            'productRef': productRef, // Include the productRef
            ...productSnapshot.data() as Map<String, dynamic>,
          });
        }
      }

      products.value = productsList;
    } catch (e) {
      log('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
