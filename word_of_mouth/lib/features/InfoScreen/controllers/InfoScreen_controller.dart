import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_snack_bar.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/utils/constants.dart';

class InfoScreenController extends GetxController {
  TextEditingController nameController = TextEditingController();
  var aboutUs = ''.obs;
  var privacyPolicy = ''.obs;
  var faqs = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var isFaqLoading = true.obs;

  var isUserDataComplete = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isEditLoading = false.obs;
  var profileImage = ''.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchStaticContent();
    fetchFAQs();
    loadUserData();
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
        privacyPolicy.value =
            docSnapshot.data()?['privacyPolicy'] ?? 'No data available';
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

  Future<void> loadUserData() async {
    isEditLoading.value = true;
    try {
      String userId = CacheHelper.getData(key: AppConstants.userId);
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

        firstNameController.text = data['firstName'] ?? '';
        lastNameController.text = data['lastName'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone'] ?? '';

        Map<String, dynamic> address = data['address'] ?? {};
        streetController.text = address['street'] ?? '';
        cityController.text = address['city'] ?? '';
        stateController.text = address['state'] ?? '';
        zipCodeController.text = address['zipCode'] ?? '';
        countryController.text = address['country'] ?? '';

        profileImage.value = data['profileImage'] ?? '';

        _updateUserDataCompleteness(); // ✅ Update completeness check
      }
    } catch (e) {
      log('❌ Error loading user data: $e');
      CommonUI.showSnackBar('Failed to load user data.');
    } finally {
      isEditLoading.value = false;
    }
  }

  void _updateUserDataCompleteness() {
    isUserDataComplete.value = firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        streetController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        zipCodeController.text.isNotEmpty &&
        countryController.text.isNotEmpty;
  }

  Future<void> editProfile() async {
    isEditLoading.value = true;
    try {
      log('Start Editing');
      String userId = CacheHelper.getData(key: AppConstants.userId);
      Map<String, dynamic> updatedData = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'address': {
          'street': streetController.text.trim(),
          'city': cityController.text.trim(),
          'state': stateController.text.trim(),
          'zipCode': zipCodeController.text.trim(),
          'country': countryController.text.trim(),
        },
        'updatedAt': DateTime.now().toIso8601String(),
      };
      log('updatedData is: $updatedData');

      await _firestore
          .collection('users')
          .doc(userId)
          .update(updatedData)
          .then((value) {
        CommonUI.showSnackBar('Profile updated successfully!');
        _updateUserDataCompleteness();
      }).catchError((e) {
        log('❌ Error updating profile: $e');
        CommonUI.showSnackBar('Failed to update profile.');
      });
    } catch (e) {
      log('❌ Error updating profile: $e');
      CommonUI.showSnackBar('Failed to update profile.');
    } finally {
      isEditLoading.value = false;
    }
  }
}
