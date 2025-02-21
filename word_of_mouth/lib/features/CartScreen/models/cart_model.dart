import 'package:get/get.dart';

class CartModel {
  final String id;
  final String name;
  final String? descripation;
  final String image;
  final double price;
  final double? priceAfterDiscount;
  RxInt quantity;

  CartModel({
    required this.id, 
    required this.name, 
    required this.image,
    required this.price, 
    required int quantity,
    this.descripation,
    this.priceAfterDiscount
  }): quantity = quantity.obs;
}
