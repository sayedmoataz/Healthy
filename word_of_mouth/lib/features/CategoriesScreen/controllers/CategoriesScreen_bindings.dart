import 'package:get/get.dart';
import 'CategoriesScreen_controller.dart';

class CategoriesScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(CategoriesScreenController());
    }
}