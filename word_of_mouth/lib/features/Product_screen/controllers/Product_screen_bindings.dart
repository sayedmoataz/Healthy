import 'package:get/get.dart';
import 'Product_screen_controller.dart';

class ProductScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ProductScreenController());
    }
}