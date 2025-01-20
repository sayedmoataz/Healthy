import 'package:get/get.dart';
import 'AllOrdersScreen_controller.dart';

class AllOrdersScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(AllOrdersScreenController());
    }
}