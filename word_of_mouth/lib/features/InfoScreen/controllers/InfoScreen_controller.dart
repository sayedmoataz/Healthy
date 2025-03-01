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

  void _updateUserDataCompleteness() {
    isUserDataComplete.value = firstNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        cityController.text.isNotEmpty;
  }

  Future<void> loadUserData() async {
    try {
      isLoading.value = true;
      String userId = CacheHelper.getData(key: AppConstants.userId);
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Initialize controllers with user data
      firstNameController.text = userData['firstName'] ?? '';
      lastNameController.text = userData['lastName'] ?? '';
      emailController.text = userData['email'] ?? '';
      phoneController.text = userData['phone'] ?? '';
      streetController.text = userData['address']['street'] ?? '';
      selectedCity.value = userData['address']['city'] ?? ''; // Initialize selected city
      stateController.text = userData['address']['state'] ?? '';
      zipCodeController.text = userData['address']['zipCode'] ?? '';
      countryController.text = userData['address']['country'] ?? '';
      profileImage.value = userData['profileImage'] ?? '';

      isLoading.value = false;
    } catch (e) {
      log('❌ Error fetching user data: ${e.toString()}');
      CommonUI.showSnackBar('Failed to fetch user data.');
    }
  }

  // Update the city in Firestore when saving the profile
  Future<void> editProfile() async {
    try {
      isEditLoading.value = true;
      String userId = CacheHelper.getData(key: AppConstants.userId);

      await _firestore.collection('users').doc(userId).update({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'phone': phoneController.text,
        'address': {
          'street': streetController.text,
          'city': selectedCity.value, // Save the selected city
          'state': stateController.text,
          'zipCode': zipCodeController.text,
          'country': countryController.text,
        },
      });

      CommonUI.showSnackBar('Profile updated successfully!');
      isEditLoading.value = false;
    } catch (e) {
      log('❌ Error updating profile: ${e.toString()}');
      CommonUI.showSnackBar('Failed to update profile.');
      isEditLoading.value = false;
    }
  }

  final List<String> cities = [
    'NasrCityCairo',
    'MaadiCairo',
    'FaisalGiza',
    'Alsharkyah',
    'Aswan',
  ];
  var selectedCity = ''.obs;

}
