import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';
import '../models/cart_model.dart';

class CartScreenController extends GetxController {
  List<CartModel> cartItems = [
    CartModel(
      name: AppStrings.appName,
      image: AppAssets.networkImage,
      price: 100,
      quantity: 1,
    ),
    CartModel(
      name: AppStrings.appName,
      image: AppAssets.networkImage,
      price: 200,
      priceAfterDiscount: 150,
      quantity: 1,
    ),
    CartModel(
      name: AppStrings.appName,
      image: AppAssets.networkImage,
      price: 300,
      quantity: 1,
      descripation: AppStrings.producrDescripation,
    ),
  ];

  TextEditingController quantityController = TextEditingController(); 
  TextEditingController couponController = TextEditingController(); 
}