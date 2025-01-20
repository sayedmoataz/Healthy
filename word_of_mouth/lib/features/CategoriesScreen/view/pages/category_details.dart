import 'package:flutter/material.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/utils/app_assets.dart';
import '../widgets/category_details_item.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Details', backable: true),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return const CategoryDetailsItem(
                          imagePath: AppAssets.networkImage,
                          categoryName: 'Category Name',
                          categoryDesc: 'Category Description',
                        );
                      },
                      childCount: 10,
                    ),
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
