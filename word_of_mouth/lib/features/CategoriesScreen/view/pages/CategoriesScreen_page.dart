import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../controllers/CategoriesScreen_controller.dart';
import '../widgets/category_item.dart';
import '../widgets/search_field.dart';

class CategoriesScreenPage extends StatelessWidget {
  final controller = Get.put(CategoriesController());

  CategoriesScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: AppStrings.categories,
              icon: Icons.shopping_bag_outlined,
              backable: false,
            ),
            CustomSearchField(controller: controller),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.categories.isEmpty) {
                  return const Center(child: Text('No categories found'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    var category = controller.categories[index];
                    return CategoryItem(
                      imagePath: category['image'],
                      categoryName: category['name'],
                      onTap: () {
                        // await controller.fetchProducts(category['id']);
                        Get.toNamed(
                          AppRoutes.categoryDetails,
                          arguments: {
                            'categoryId': category['id'],
                          },
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
