import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_snack_bar.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/routing/app_routes.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp({
    required String email,
    required String mobileNumber,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName('$firstName $lastName');
        CacheHelper.putData(key: AppConstants.userId, value: user.uid);
        await setupUserDocuments(
          userId: user.uid,
          email: email,
          firstName: firstName,
          lastName: lastName,
          phone: mobileNumber,
        );

        CommonUI.showSnackBar('Account created successfully!');
        await login(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      CommonUI.showSnackBar(e.message ?? 'An error occurred during sign up.');
    } catch (e) {
      log('❌ Signup error: ${e.toString()}');
      CommonUI.showSnackBar('An error occurred during sign up.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        String? token = await user.getIdToken();
        await CacheHelper.putData(key: AppConstants.userToken, value: token);
        CommonUI.showSnackBar('Login successfully!');
        Get.offAllNamed(AppRoutes.landingScreen);
      }
    } on FirebaseAuthException catch (e) {
      CommonUI.showSnackBar(e.message ?? 'An error occurred during login.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await CacheHelper.deleteData(key: AppConstants.userToken);
    CommonUI.showSnackBar('Logout successfully!');
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  Future<void> setupUserDocuments({
    required String userId,
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'address': {
          'street': '',
          'city': '',
          'state': '',
          'zipCode': '',
          'country': '',
        },
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
        'lastLogin': DateTime.now().toIso8601String(),
      });

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc('info')
          .set({
        'totalOrders': 0,
        'lastOrderDate': null,
        'totalSpent': 0.0,
      });

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc('info')
          .set({
        'totalItems': 0,
        'subtotal': 0.0,
        'discount': 0.0,
        'tax': 0.0,
        'total': 0.0,
        'lastUpdated': DateTime.now().toIso8601String(),
      });

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc('info')
          .set({
        'totalItems': 0,
        'lastUpdated': DateTime.now().toIso8601String(),
      });

      log('✅ User document structure initialized successfully!');
    } catch (e) {
      log('❌ Error setting up user documents: ${e.toString()}');
      rethrow;
    }
  }
}
  // Future<void> addToFavorites({
  //   required String userId,
  //   required String productId,
  //   required Map<String, dynamic> productData,
  // }) async {
  //   try {
  //     // Add product to favorites collection
  //     await _firestore
  //         .collection('users')
  //         .doc(userId)
  //         .collection('favorites')
  //         .doc(productId)
  //         .set({
  //       'productId': productId,
  //       'productName': productData['name'],
  //       'price': productData['priceAfter'],
  //       'image': productData['image'],
  //       'addedAt': DateTime.now().toIso8601String(),
  //     });
  //     // Update favorites info document
  //     QuerySnapshot favItems = await _firestore
  //         .collection('users')
  //         .doc(userId)
  //         .collection('favorites')
  //         .where(FieldPath.documentId, isNotEqualTo: 'info')
  //         .get();
  //     await _firestore
  //         .collection('users')
  //         .doc(userId)
  //         .collection('favorites')
  //         .doc('info')
  //         .update({
  //       'totalItems': favItems.docs.length,
  //       'lastUpdated': DateTime.now().toIso8601String(),
  //     });
  //     log('✅ Product added to favorites successfully!');
  //   } catch (e) {
  //     log('❌ Error adding to favorites: ${e.toString()}');
  //     CommonUI.showSnackBar('Failed to add product to favorites.');
  //     rethrow;
  //   }
  // }

  // // Remove product from favorites

  // Future<void> removeFromFavorites({
  //   required String userId,
  //   required String productId,
  // }) async {
  //   try {
  //     await _firestore
  //         .collection('users')
  //         .doc(userId)
  //         .collection('favorites')
  //         .doc(productId)
  //         .delete();
  //     // Update favorites info document
  //     QuerySnapshot favItems = await _firestore
  //         .collection('users')
  //         .doc(userId)
  //         .collection('favorites')
  //         .where(FieldPath.documentId, isNotEqualTo: 'info')
  //         .get();
  //     await _firestore
  //         .collection('users')
  //         .doc(userId)
  //         .collection('favorites')
  //         .doc('info')
  //         .update({
  //       'totalItems': favItems.docs.length,
  //       'lastUpdated': DateTime.now().toIso8601String(),
  //     });
  //     log('✅ Product removed from favorites successfully!');
  //   } catch (e) {
  //     log('❌ Error removing from favorites: ${e.toString()}');
  //     CommonUI.showSnackBar('Failed to remove product from favorites.');
  //     rethrow;
  //   }
  // }

  
  // // Get user order history

  // Future<List<Map<String, dynamic>>> getOrderHistory(String userId) async {
  //   try {
  //     QuerySnapshot orderSnapshot = await _firestore
  //         .collection('users')
  //         .doc(userId)
  //         .collection('orders')
  //         .where(FieldPath.documentId, isNotEqualTo: 'info')
  //         .orderBy('orderDate', descending: true)
  //         .get();
  //     List<Map<String, dynamic>> orders = [];
  //     for (var doc in orderSnapshot.docs) {
  //       orders.add(doc.data() as Map<String, dynamic>);
  //     }
  //     return orders;
  //   } catch (e) {
  //     log('❌ Error fetching order history: ${e.toString()}');
  //     rethrow;
  //   }
  // }

