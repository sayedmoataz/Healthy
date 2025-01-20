
import 'package:get/get.dart';

class CategoriesScreenController extends GetxController {
  final searchQuery = ''.obs;

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}