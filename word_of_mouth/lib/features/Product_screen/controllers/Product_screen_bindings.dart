import 'package:get/get.dart';
import 'Product_screen_controller.dart';

class ProductScreenBindings implements Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null || args['productId'] == null || args['collectionName'] == null) {
      throw ArgumentError('productId and collectionName must be provided');
    }
    Get.put(ProductScreenController(
      productId: args['productId'] as String,
      collectionName: args['collectionName'] as String,
    ));
  }
}