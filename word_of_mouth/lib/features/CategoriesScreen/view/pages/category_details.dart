import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../controllers/category_details_controller.dart';
import '../widgets/category_details_item.dart';

class CategoryDetails extends StatelessWidget {
  final String categoryId;

  const CategoryDetails({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(CategoryDetailsController(categoryId: categoryId));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Details', backable: true),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.products.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                return CustomScrollView(
                  slivers: [
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var product = controller.products[index];
                          return CategoryDetailsItem(
                            imagePath: product['images'][0],
                            categoryName: product['name'],
                            categoryDesc: product['description'],
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.productScreen,
                                arguments: {
                                  'productId': product['id'],
                                  'collectionName': 'categories',
                                },
                              );
                            },
                          );
                        },
                        childCount: controller.products.length,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
