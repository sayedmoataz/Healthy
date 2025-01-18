import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../controllers/CategoriesScreen_controller.dart';
import '../widgets/category_item.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_field.dart';

class CategoriesScreenPage extends StatelessWidget {
  final controller = Get.put(CategoriesScreenController());

  CategoriesScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            const CustomAppBar(title: AppStrings.categories),
            // Search Bar
            CustomSearchField(controller: controller),

            // Sales Banner List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  CategoryItem(
                    imagePath: AppAssets.networkImage,
                    categoryName: AppStrings.appName,
                  ),
                  CategoryItem(
                    imagePath: AppAssets.networkImage,
                    categoryName: AppStrings.appName,
                  ),
                  CategoryItem(
                    imagePath: AppAssets.networkImage,
                    categoryName: AppStrings.appName,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
