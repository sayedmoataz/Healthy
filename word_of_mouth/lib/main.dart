import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app_root.dart';
import 'core/services/cache_helper.dart';
import 'core/utils/app_assets.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await addFirestoreData();
  runApp(const MyAppRoot());
}

Future<void> addFirestoreData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 🌟 1. Add all products to the 'allProducts' document in 'globalData'
  Map<String, Map<String, dynamic>> allProducts = {
    'iphone_15': {
      'name': 'iPhone 15',
      'image': AppAssets.networkImage,
      'priceBefore': 1200,
      'priceAfter': 999,
      'discount': 20,
      'availableQuantity': 50,
      'description': 'Latest Apple iPhone with A16 chip.',
      'images': [AppAssets.networkImage, AppAssets.networkImage],
      'isFeatured': true,
      'isPopular': true,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': true,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'electronics',
      'relatedProducts': {
        'airpods_pro': {
          'productRef': firestore
              .collection('globalData')
              .doc('allProducts')
              .collection('items')
              .doc('airpods_pro'),
        },
        'apple_watch': {
          'productRef': firestore
              .collection('globalData')
              .doc('allProducts')
              .collection('items')
              .doc('apple_watch'),
        },
      },
    },
    'airpods_pro': {
      'name': 'AirPods Pro',
      'image': AppAssets.networkImage,
      'priceBefore': 250,
      'priceAfter': 199,
      'discount': 20,
      'availableQuantity': 100,
      'description': 'Wireless earbuds with noise cancellation.',
      'images': [AppAssets.networkImage, AppAssets.networkImage],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': 'iphone_15',
      'relatedToWhichCategory': null,
    },
    'apple_watch': {
      'name': 'Apple Watch',
      'image': AppAssets.networkImage,
      'priceBefore': 400,
      'priceAfter': 350,
      'discount': 12,
      'availableQuantity': 80,
      'description': 'Smartwatch with health tracking features.',
      'images': [AppAssets.networkImage, AppAssets.networkImage],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': 'iphone_15',
      'relatedToWhichCategory': null,
    },
    'samsung_tv': {
      'name': 'Samsung QLED 4K TV',
      'image': AppAssets.networkImage,
      'priceBefore': 1500,
      'priceAfter': 1299,
      'discount': 13,
      'availableQuantity': 30,
      'description': 'Premium 4K Smart TV with Quantum Dot technology.',
      'images': [AppAssets.networkImage, AppAssets.networkImage],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': true,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'electronics',
    },
    'nike_shoes': {
      'name': 'Nike Air Max',
      'image': AppAssets.networkImage,
      'priceBefore': 180,
      'priceAfter': 149,
      'discount': 17,
      'availableQuantity': 120,
      'description': 'Comfortable running shoes with air cushioning.',
      'images': [AppAssets.networkImage, AppAssets.networkImage],
      'isFeatured': false,
      'isPopular': true,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'fashion',
    },
    'adidas_jacket': {
      'name': 'Adidas Track Jacket',
      'image': AppAssets.networkImage,
      'priceBefore': 90,
      'priceAfter': 75,
      'discount': 16,
      'availableQuantity': 85,
      'description': 'Classic track jacket with three stripes design.',
      'images': [AppAssets.networkImage, AppAssets.networkImage],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'fashion',
    },
    'macbook_pro': {
      'name': 'MacBook Pro 16"',
      'image': AppAssets.networkImage,
      'priceBefore': 2499,
      'priceAfter': 2199,
      'discount': 12,
      'availableQuantity': 25,
      'description': 'Powerful laptop with M3 Pro chip and stunning display.',
      'images': [AppAssets.networkImage, AppAssets.networkImage],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': true,
      'timerOfSuperFlash':
          DateTime.now().add(const Duration(days: 2)).toIso8601String(),
      'isRelated': false,
      'relatedToWhichProduct': 'iphone_15',
      'relatedToWhichCategory': 'electronics',
    },
    'gaming_laptop': {
      'name': 'ASUS ROG Gaming Laptop',
      'image': AppAssets.networkImage,
      'priceBefore': 1899,
      'priceAfter': 1699,
      'discount': 10,
      'availableQuantity': 40,
      'description': 'High-performance gaming laptop with RTX 4080.',
      'images': [AppAssets.networkImage, AppAssets.networkImage],
      'isFeatured': true,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'electronics',
    },
  };

  for (var product in allProducts.entries) {
    await firestore
        .collection('globalData')
        .doc('allProducts')
        .collection('items')
        .doc(product.key)
        .set(product.value);
  }

  // 🌟 2. Add Categories with References to Products
  Map<String, List<String>> categories = {
    'electronics': ['iphone_15', 'samsung_tv'],
    'fashion': ['nike_shoes', 'adidas_jacket'],
  };

  for (var category in categories.entries) {
    DocumentReference categoryRef = firestore
        .collection('globalData')
        .doc('categories')
        .collection('items')
        .doc(category.key);

    await categoryRef.set({
      'name': category.key,
      'image': AppAssets.networkImage,
    });

    for (var productId in category.value) {
      await categoryRef.collection('products').doc(productId).set({
        'productRef': firestore
            .collection('globalData')
            .doc('allProducts')
            .collection('items')
            .doc(productId),
      });
    }
  }

  // 🌟 3. Add Popular Products (References to 'allProducts')
  List<String> popularProducts = ['iphone_15', 'nike_shoes'];

  for (var productId in popularProducts) {
    await firestore
        .collection('globalData')
        .doc('popularProducts')
        .collection('items')
        .doc(productId)
        .set({
      'productRef': firestore
          .collection('globalData')
          .doc('allProducts')
          .collection('items')
          .doc(productId),
    });
  }

  // 🌟 4. Add Flash Sale Products (References to 'allProducts')
  List<String> flashSale = ['samsung_tv'];

  for (var productId in flashSale) {
    await firestore
        .collection('globalData')
        .doc('flashSaleProducts')
        .collection('items')
        .doc(productId)
        .set({
      'productRef': firestore
          .collection('globalData')
          .doc('allProducts')
          .collection('items')
          .doc(productId),
    });
  }

  // 🌟 5. Add Super Flash Sale Products (References to 'allProducts')
  List<String> superFlashSale = ['macbook_pro'];

  for (var productId in superFlashSale) {
    await firestore
        .collection('globalData')
        .doc('superFlashSaleProducts')
        .collection('items')
        .doc(productId)
        .set({
      'productRef': firestore
          .collection('globalData')
          .doc('allProducts')
          .collection('items')
          .doc(productId),
    });
  }

  // 🌟 6. Add Featured Products (References to 'allProducts')
  List<String> featuredProducts = ['gaming_laptop'];

  for (var productId in featuredProducts) {
    await firestore
        .collection('globalData')
        .doc('featuredProducts')
        .collection('items')
        .doc(productId)
        .set({
      'productRef': firestore
          .collection('globalData')
          .doc('allProducts')
          .collection('items')
          .doc(productId),
    });
  }
  // 🌟 7. Add Featured Products (References to 'allProducts')
  List<String> newArrivalProducts = ['airpods_pro'];

  for (var productId in newArrivalProducts) {
    await firestore
        .collection('globalData')
        .doc('newArrivalProducts')
        .collection('items')
        .doc(productId)
        .set({
      'productRef': firestore
          .collection('globalData')
          .doc('allProducts')
          .collection('items')
          .doc(productId),
    });
  }

  // 🌟 8. Add Static Content (About Us, FAQ, Privacy Policy)
  await firestore.collection('globalData').doc('staticContent').set({
    'aboutUs': 'We are a leading e-commerce platform...',
    'privacyPolicy': 'Your data is protected and we follow GDPR regulations...',
  });

  await firestore.collection('globalData').doc('faq').collection('items').add({
    'question': 'How to buy?',
    'answer': 'Add products to cart and checkout.'
  });

  log('✅ Firestore Data Added Successfully!');
}
