import 'package:get/get.dart';
import 'HomeScreen_controller.dart';

class HomeScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(HomeScreenController());
    }
}