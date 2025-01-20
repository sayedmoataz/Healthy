import 'package:get/get.dart';
import 'CartScreen_controller.dart';

class CartScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(CartScreenController());
    }
}