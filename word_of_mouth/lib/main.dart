import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app_root.dart';
import 'core/services/cache_helper.dart';
import 'core/utils/app_assets.dart';
import 'core/utils/app_strings.dart';
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
    'istanbul_cheese': {
      'name': 'جبن اسطنبولي',
      'image':
          'https://healthymilk.net/wp-content/uploads/2022/04/IMG_1030-480x320.jpg',
      'priceBefore': 50,
      'priceAfter': 40,
      'discount': 20,
      'availableQuantity': 100,
      'description': 'Delicious Istanbul cheese with a rich flavor.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2023/08/104320690_3372861539390939_4395661989431978374_n-2-480x640.webp',
        'https://healthymilk.net/wp-content/uploads/2019/06/products_04_01-500x668.jpg'
      ],
      'isFeatured': true,
      'isPopular': true,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': true,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'dairy',
      'relatedProducts': {
        'strawberry_yogurt': {
          'productRef': firestore
              .collection('globalData')
              .doc('allProducts')
              .collection('items')
              .doc('strawberry_yogurt'),
        },
        'mango_nectar': {
          'productRef': firestore
              .collection('globalData')
              .doc('allProducts')
              .collection('items')
              .doc('mango_nectar'),
        },
      },
    },
    'mango_nectar': {
      'name': 'نكتار مانجو',
      'image': AppAssets.networkImage,
      'priceBefore': 30,
      'priceAfter': 25,
      'discount': 16,
      'availableQuantity': 150,
      'description': 'Refreshing mango nectar made from fresh mangoes.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2023/08/101304381_4212530392152714_651453188031831000_n-480x480.jpg',
        'https://healthymilk.net/wp-content/uploads/2019/06/post-1-juice-480x640.webp'
      ],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': 'istanbul_cheese',
      'relatedToWhichCategory': null,
    },
    'strawberry_yogurt': {
      'name': 'لبن بالفراولة',
      'image':
          'https://healthymilk.net/wp-content/uploads/2022/04/IMG_9840-480x640.jpg',
      'priceBefore': 35,
      'priceAfter': 30,
      'discount': 14,
      'availableQuantity': 120,
      'description': 'Creamy yogurt with the sweetness of strawberries.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2022/04/IMG_9840.jpg',
        'https://healthymilk.net/wp-content/uploads/2023/07/IMG_1021-480x320.jpg'
      ],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': 'istanbul_cheese',
      'relatedToWhichCategory': null,
    },
    'chocolate_milk': {
      'name': 'حليب بالشوكولاتة',
      'image':
          'https://healthymilk.net/wp-content/uploads/2019/06/post-1-juice-480x640.webp',
      'priceBefore': 40,
      'priceAfter': 35,
      'discount': 12,
      'availableQuantity': 80,
      'description': 'Rich and creamy chocolate milk for a delightful treat.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2023/04/IMG_1027-480x320.jpg',
        'https://healthymilk.net/wp-content/uploads/2023/04/IMG_0024-480x320.jpg'
      ],
      'isFeatured': false,
      'isPopular': true,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'dairy',
    },
    'vanilla_yogurt': {
      'name': 'لبن بالفانيلا',
      'image':
          'https://healthymilk.net/wp-content/uploads/2023/07/IMG_0987-480x320.jpg',
      'priceBefore': 30,
      'priceAfter': 25,
      'discount': 16,
      'availableQuantity': 90,
      'description': 'Smooth vanilla yogurt with a hint of sweetness.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2023/04/IMG_0019-480x320.jpg',
      ],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': true,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'dairy',
    },
    'labneh': {
      'name': 'لبنة',
      'image':
          'https://healthymilk.net/wp-content/uploads/2023/07/IMG_1040-480x320.jpg',
      'priceBefore': 45,
      'priceAfter': 40,
      'discount': 11,
      'availableQuantity': 70,
      'description': 'Traditional labneh with a rich and tangy flavor.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2023/08/104320690_3372861539390939_4395661989431978374_n-2-480x321.jpg',
        AppAssets.networkImage
      ],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': true,
      'timerOfSuperFlash':
          DateTime.now().add(const Duration(days: 2)).toIso8601String(),
      'isRelated': false,
      'relatedToWhichProduct': 'istanbul_cheese',
      'relatedToWhichCategory': 'dairy',
    },
    'orange_juice': {
      'name': 'عصير برتقال',
      'image':
          'https://healthymilk.net/wp-content/uploads/2022/04/IMG_0040-480x635.jpg',
      'priceBefore': 25,
      'priceAfter': 20,
      'discount': 20,
      'availableQuantity': 200,
      'description': 'Freshly squeezed orange juice, rich in vitamin C.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2022/04/IMG_0040-480x635.jpg',
        'https://healthymilk.net/wp-content/uploads/2019/06/post-1-juice-480x640.webp'
      ],
      'isFeatured': false,
      'isPopular': true,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'beverages',
    },
    'pomegranate_juice': {
      'name': 'عصير رمان',
      'image':
          'https://healthymilk.net/wp-content/uploads/2019/06/post-1-juice-480x640.webp',
      'priceBefore': 35,
      'priceAfter': 30,
      'discount': 14,
      'availableQuantity': 150,
      'description': 'Pure pomegranate juice with a tangy and sweet flavor.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2023/08/104320690_3372861539390939_4395661989431978374_n-480x480.jpg'
      ],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': true,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'beverages',
    },
    'mixed_nuts': {
      'name': 'عروض العودة للمدرسة',
      'image':
          'https://healthymilk.net/wp-content/uploads/2023/09/376422216_661987009254920_5700470096080632635_n-1-480x480.jpg',
      'priceBefore': 60,
      'priceAfter': 50,
      'discount': 16,
      'availableQuantity': 100,
      'description':
          'A mix of premium nuts including almonds, cashews, and walnuts.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2023/09/376422216_661987009254920_5700470096080632635_n-1-480x480.jpg'
      ],
      'isFeatured': true,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'snacks',
    },
    'honey': {
      'name': 'عرض العودة للمدرسة ٢',
      'image':
          'https://healthymilk.net/wp-content/uploads/2023/09/375211710_661987012588253_236628043357793652_n-1-480x480.jpg',
      'priceBefore': 80,
      'priceAfter': 70,
      'discount': 12,
      'availableQuantity': 60,
      'description': 'Pure natural honey with a rich and smooth texture.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2023/09/375211710_661987012588253_236628043357793652_n-1-480x480.jpg'
      ],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': true,
      'timerOfSuperFlash':
          DateTime.now().add(const Duration(days: 3)).toIso8601String(),
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'natural',
    },
    'date_syrup': {
      'name': 'هرض العودة للمدرسة ٣',
      'image':
          'https://healthymilk.net/wp-content/uploads/2023/09/375174367_661987022588252_195841530605391519_n-1-480x480.jpg',
      'priceBefore': 40,
      'priceAfter': 35,
      'discount': 12,
      'availableQuantity': 90,
      'description': 'Natural date syrup, perfect for sweetening dishes.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2023/09/375174367_661987022588252_195841530605391519_n-1-480x480.jpg'
      ],
      'isFeatured': false,
      'isPopular': false,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'natural',
    },
    'olive_oil': {
      'name': 'عرض العودة للمدرسة ٣',
      'image':
          'https://healthymilk.net/wp-content/uploads/2023/09/375174367_661987022588252_195841530605391519_n-1-480x480.jpg',
      'priceBefore': 100,
      'priceAfter': 90,
      'discount': 10,
      'availableQuantity': 50,
      'description': 'Extra virgin olive oil, cold-pressed for maximum flavor.',
      'images': [
        'https://healthymilk.net/wp-content/uploads/2023/09/375174367_661987022588252_195841530605391519_n-1-480x480.jpg'
      ],
      'isFeatured': false,
      'isPopular': true,
      'isFlashSale': false,
      'isSuperFlash': false,
      'timerOfSuperFlash': null,
      'isRelated': false,
      'relatedToWhichProduct': null,
      'relatedToWhichCategory': 'natural',
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
    'ألبان': ['istanbul_cheese', 'strawberry_yogurt'],
    'عصائر': [
      'mango_nectar',
      'chocolate_milk',
      'orange_juice',
      'pomegranate_juice'
    ],
    'منتجات جديدة': ['mixed_nuts'],
    'العروض': ['honey', 'date_syrup', 'olive_oil'],
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
  List<String> popularProducts = [
    'istanbul_cheese',
    'chocolate_milk',
    'orange_juice',
    'olive_oil'
  ];

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
  List<String> flashSale = ['vanilla_yogurt', 'pomegranate_juice'];

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
  List<String> superFlashSale = ['labneh', 'honey'];

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
  List<String> featuredProducts = ['istanbul_cheese', 'mixed_nuts'];

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

  // 🌟 7. Add New Arrival Products (References to 'allProducts')
  List<String> newArrivalProducts = ['mango_nectar', 'date_syrup'];

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
    'aboutUs': AppStrings.about,
    'privacyPolicy': AppStrings.privacyText,
  });

  await firestore.collection('globalData').doc('faq').collection('items').add({
    'question': 'What products do you offer?',
    'answer':
        'We offer a variety of dairy products, beverages, snacks, and natural products.',
  });

  log('✅ Firestore Data Added Successfully!');
}
// Future<void> addFirestoreData() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   // 🌟 1. Add all products to the 'allProducts' document in 'globalData'
//   Map<String, Map<String, dynamic>> allProducts = {
//     'iphone_15': {
//       'name': 'iPhone 15',
//       'image': AppAssets.networkImage,
//       'priceBefore': 1200,
//       'priceAfter': 999,
//       'discount': 20,
//       'availableQuantity': 50,
//       'description': 'Latest Apple iPhone with A16 chip.',
//       'images': [AppAssets.networkImage, AppAssets.networkImage],
//       'isFeatured': true,
//       'isPopular': true,
//       'isFlashSale': false,
//       'isSuperFlash': false,
//       'timerOfSuperFlash': null,
//       'isRelated': true,
//       'relatedToWhichProduct': null,
//       'relatedToWhichCategory': 'electronics',
//       'relatedProducts': {
//         'airpods_pro': {
//           'productRef': firestore
//               .collection('globalData')
//               .doc('allProducts')
//               .collection('items')
//               .doc('airpods_pro'),
//         },
//         'apple_watch': {
//           'productRef': firestore
//               .collection('globalData')
//               .doc('allProducts')
//               .collection('items')
//               .doc('apple_watch'),
//         },
//       },
//     },
//     'airpods_pro': {
//       'name': 'AirPods Pro',
//       'image': AppAssets.networkImage,
//       'priceBefore': 250,
//       'priceAfter': 199,
//       'discount': 20,
//       'availableQuantity': 100,
//       'description': 'Wireless earbuds with noise cancellation.',
//       'images': [AppAssets.networkImage, AppAssets.networkImage],
//       'isFeatured': false,
//       'isPopular': false,
//       'isFlashSale': false,
//       'isSuperFlash': false,
//       'timerOfSuperFlash': null,
//       'isRelated': false,
//       'relatedToWhichProduct': 'iphone_15',
//       'relatedToWhichCategory': null,
//     },
//     'apple_watch': {
//       'name': 'Apple Watch',
//       'image': AppAssets.networkImage,
//       'priceBefore': 400,
//       'priceAfter': 350,
//       'discount': 12,
//       'availableQuantity': 80,
//       'description': 'Smartwatch with health tracking features.',
//       'images': [AppAssets.networkImage, AppAssets.networkImage],
//       'isFeatured': false,
//       'isPopular': false,
//       'isFlashSale': false,
//       'isSuperFlash': false,
//       'timerOfSuperFlash': null,
//       'isRelated': false,
//       'relatedToWhichProduct': 'iphone_15',
//       'relatedToWhichCategory': null,
//     },
//     'samsung_tv': {
//       'name': 'Samsung QLED 4K TV',
//       'image': AppAssets.networkImage,
//       'priceBefore': 1500,
//       'priceAfter': 1299,
//       'discount': 13,
//       'availableQuantity': 30,
//       'description': 'Premium 4K Smart TV with Quantum Dot technology.',
//       'images': [AppAssets.networkImage, AppAssets.networkImage],
//       'isFeatured': false,
//       'isPopular': false,
//       'isFlashSale': true,
//       'isSuperFlash': false,
//       'timerOfSuperFlash': null,
//       'isRelated': false,
//       'relatedToWhichProduct': null,
//       'relatedToWhichCategory': 'electronics',
//     },
//     'nike_shoes': {
//       'name': 'Nike Air Max',
//       'image': AppAssets.networkImage,
//       'priceBefore': 180,
//       'priceAfter': 149,
//       'discount': 17,
//       'availableQuantity': 120,
//       'description': 'Comfortable running shoes with air cushioning.',
//       'images': [AppAssets.networkImage, AppAssets.networkImage],
//       'isFeatured': false,
//       'isPopular': true,
//       'isFlashSale': false,
//       'isSuperFlash': false,
//       'timerOfSuperFlash': null,
//       'isRelated': false,
//       'relatedToWhichProduct': null,
//       'relatedToWhichCategory': 'fashion',
//     },
//     'adidas_jacket': {
//       'name': 'Adidas Track Jacket',
//       'image': AppAssets.networkImage,
//       'priceBefore': 90,
//       'priceAfter': 75,
//       'discount': 16,
//       'availableQuantity': 85,
//       'description': 'Classic track jacket with three stripes design.',
//       'images': [AppAssets.networkImage, AppAssets.networkImage],
//       'isFeatured': false,
//       'isPopular': false,
//       'isFlashSale': false,
//       'isSuperFlash': false,
//       'timerOfSuperFlash': null,
//       'isRelated': false,
//       'relatedToWhichProduct': null,
//       'relatedToWhichCategory': 'fashion',
//     },
//     'macbook_pro': {
//       'name': 'MacBook Pro 16"',
//       'image': AppAssets.networkImage,
//       'priceBefore': 2499,
//       'priceAfter': 2199,
//       'discount': 12,
//       'availableQuantity': 25,
//       'description': 'Powerful laptop with M3 Pro chip and stunning display.',
//       'images': [AppAssets.networkImage, AppAssets.networkImage],
//       'isFeatured': false,
//       'isPopular': false,
//       'isFlashSale': false,
//       'isSuperFlash': true,
//       'timerOfSuperFlash':
//           DateTime.now().add(const Duration(days: 2)).toIso8601String(),
//       'isRelated': false,
//       'relatedToWhichProduct': 'iphone_15',
//       'relatedToWhichCategory': 'electronics',
//     },
//     'gaming_laptop': {
//       'name': 'ASUS ROG Gaming Laptop',
//       'image': AppAssets.networkImage,
//       'priceBefore': 1899,
//       'priceAfter': 1699,
//       'discount': 10,
//       'availableQuantity': 40,
//       'description': 'High-performance gaming laptop with RTX 4080.',
//       'images': [AppAssets.networkImage, AppAssets.networkImage],
//       'isFeatured': true,
//       'isPopular': false,
//       'isFlashSale': false,
//       'isSuperFlash': false,
//       'timerOfSuperFlash': null,
//       'isRelated': false,
//       'relatedToWhichProduct': null,
//       'relatedToWhichCategory': 'electronics',
//     },
//   };
//   for (var product in allProducts.entries) {
//     await firestore
//         .collection('globalData')
//         .doc('allProducts')
//         .collection('items')
//         .doc(product.key)
//         .set(product.value);
//   }
//   // 🌟 2. Add Categories with References to Products
//   Map<String, List<String>> categories = {
//     'electronics': ['iphone_15', 'samsung_tv'],
//     'fashion': ['nike_shoes', 'adidas_jacket'],
//   };
//   for (var category in categories.entries) {
//     DocumentReference categoryRef = firestore
//         .collection('globalData')
//         .doc('categories')
//         .collection('items')
//         .doc(category.key);
//     await categoryRef.set({
//       'name': category.key,
//       'image': AppAssets.networkImage,
//     });
//     for (var productId in category.value) {
//       await categoryRef.collection('products').doc(productId).set({
//         'productRef': firestore
//             .collection('globalData')
//             .doc('allProducts')
//             .collection('items')
//             .doc(productId),
//       });
//     }
//   }
//   // 🌟 3. Add Popular Products (References to 'allProducts')
//   List<String> popularProducts = ['iphone_15', 'nike_shoes'];
//   for (var productId in popularProducts) {
//     await firestore
//         .collection('globalData')
//         .doc('popularProducts')
//         .collection('items')
//         .doc(productId)
//         .set({
//       'productRef': firestore
//           .collection('globalData')
//           .doc('allProducts')
//           .collection('items')
//           .doc(productId),
//     });
//   }
//   // 🌟 4. Add Flash Sale Products (References to 'allProducts')
//   List<String> flashSale = ['samsung_tv'];
//   for (var productId in flashSale) {
//     await firestore
//         .collection('globalData')
//         .doc('flashSaleProducts')
//         .collection('items')
//         .doc(productId)
//         .set({
//       'productRef': firestore
//           .collection('globalData')
//           .doc('allProducts')
//           .collection('items')
//           .doc(productId),
//     });
//   }
//   // 🌟 5. Add Super Flash Sale Products (References to 'allProducts')
//   List<String> superFlashSale = ['macbook_pro'];
//   for (var productId in superFlashSale) {
//     await firestore
//         .collection('globalData')
//         .doc('superFlashSaleProducts')
//         .collection('items')
//         .doc(productId)
//         .set({
//       'productRef': firestore
//           .collection('globalData')
//           .doc('allProducts')
//           .collection('items')
//           .doc(productId),
//     });
//   }
//   // 🌟 6. Add Featured Products (References to 'allProducts')
//   List<String> featuredProducts = ['gaming_laptop'];
//   for (var productId in featuredProducts) {
//     await firestore
//         .collection('globalData')
//         .doc('featuredProducts')
//         .collection('items')
//         .doc(productId)
//         .set({
//       'productRef': firestore
//           .collection('globalData')
//           .doc('allProducts')
//           .collection('items')
//           .doc(productId),
//     });
//   }
//   // 🌟 7. Add Featured Products (References to 'allProducts')
//   List<String> newArrivalProducts = ['airpods_pro'];
//   for (var productId in newArrivalProducts) {
//     await firestore
//         .collection('globalData')
//         .doc('newArrivalProducts')
//         .collection('items')
//         .doc(productId)
//         .set({
//       'productRef': firestore
//           .collection('globalData')
//           .doc('allProducts')
//           .collection('items')
//           .doc(productId),
//     });
//   }
//   // 🌟 8. Add Static Content (About Us, FAQ, Privacy Policy)
//   await firestore.collection('globalData').doc('staticContent').set({
//     'aboutUs': AppStrings.about,
//     'privacyPolicy': AppStrings.privacyText,
//   });
//   await firestore.collection('globalData').doc('faq').collection('items').add({
//     'question': 'What products do you offer?',
//     'answer': 'Describe your business offerings (e.g., products, subscriptions, consulting services).',
//   });
//   log('✅ Firestore Data Added Successfully!');
// }
