import 'package:get/get.dart';
import 'NavigationBar_controller.dart';

class NavigationBarBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(NavigationBarController());
    }
}