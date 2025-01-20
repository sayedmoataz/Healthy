import 'package:get/get.dart';
import 'InfoScreen_controller.dart';

class InfoScreenBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(InfoScreenController());
    }
}