import 'package:get/get.dart';

class ProductScreenController extends GetxController {
  var quantity = 1.obs;

  void increment() => quantity++;
  void decrement() {
    if (quantity > 1) quantity--;
  }
}