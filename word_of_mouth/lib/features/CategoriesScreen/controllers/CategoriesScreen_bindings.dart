import 'dart:developer';

import 'package:get/get.dart';
import 'CategoriesScreen_controller.dart';

class CategoriesScreenBindings implements Bindings {
  @override
  void dependencies() {
    log('binding start in categories');
    Get.put(CategoriesController());
  }
}
