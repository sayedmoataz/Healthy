import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';

// For preview
class CategoryModel {
  final String name;
  final String? route;

  CategoryModel({
    required this.name,
    this.route,
  });
}

List<CategoryModel> demoCategories = [
  CategoryModel(name: 'All Categories', route: ''),
  CategoryModel(name: 'Butter', route: ''),
  CategoryModel(name: 'Ice Cream', route: ''),
  CategoryModel(name: 'Juice', route: ''),
  CategoryModel(name: 'Cheese', route: ''),
];

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            demoCategories.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                left: index == 0
                    ? AppConstants.defaultPadding
                    : AppConstants.defaultPadding / 2,
                right: index == demoCategories.length - 1
                    ? AppConstants.defaultPadding
                    : 0,
              ),
              child: CategoryBtn(
                category: demoCategories[index].name,
                press: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.category,
    required this.press,
  });

  final String category;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 24.h,
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        decoration: BoxDecoration(
          color: AppColors.transparentColor,
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ),
    );
  }
}
