import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoScreenController extends GetxController {
  TextEditingController nameController = TextEditingController();
  var aboutUs = ''.obs;
  var privacyPolicy = ''.obs;
  var faqs = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var isFaqLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStaticContent();
    fetchFAQs();
  }

  Future<void> fetchStaticContent() async {
    try {
      isLoading.value = true;
      var docSnapshot = await FirebaseFirestore.instance
          .collection('globalData')
          .doc('staticContent')
          .get();

      if (docSnapshot.exists) {
        aboutUs.value = docSnapshot.data()?['aboutUs'] ?? 'No data available';
        privacyPolicy.value = docSnapshot.data()?['privacyPolicy'] ?? 'No data available';
      }
    } catch (e) {
      log('Error fetching static content: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFAQs() async {
    try {
      isFaqLoading.value = true;
      var faqSnapshot = await FirebaseFirestore.instance
          .collection('globalData')
          .doc('faq')
          .collection('items')
          .get();

      faqs.value = faqSnapshot.docs.map((doc) {
        return {
          'question': doc.data()['question'] ?? 'No question available',
          'answer': doc.data()['answer'] ?? 'No answer available',
        };
      }).toList();
    } catch (e) {
      log('Error fetching FAQs: $e');
    } finally {
      isFaqLoading.value = false;
    }
  }
}
