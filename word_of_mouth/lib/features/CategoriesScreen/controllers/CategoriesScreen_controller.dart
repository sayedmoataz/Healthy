import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoriesScreenController extends GetxController {
  var searchQuery = ''.obs;
  var categories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
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
    }
  }
}
