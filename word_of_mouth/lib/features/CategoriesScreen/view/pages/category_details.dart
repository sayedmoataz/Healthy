import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../controllers/CategoriesScreen_controller.dart';
import '../widgets/category_details_item.dart';

class CategoryDetails extends StatelessWidget {
  final String categoryId;

  const CategoryDetails({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProducts(categoryId);
    });

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

                return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    var product = controller.products[index];
                    return CategoryDetailsItem(
                      imagePath: product['images'][0],
                      categoryName: product['name'],
                      categoryDescripation: product['description'],
                      priceAfter: product['priceAfter'],
                      priceBefore: product['priceBefore'],
                      productId: product['id'],
                      onTap: () {
                        var productRef =
                            product['productRef'] as DocumentReference;
                        var productId = productRef.id;
                        Get.toNamed(
                          AppRoutes.productScreen,
                          arguments: {
                            'productId': productId,
                            'collectionName': 'allProducts',
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
