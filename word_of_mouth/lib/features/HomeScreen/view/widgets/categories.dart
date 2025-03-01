import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/animations/animation_do.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../../CategoriesScreen/controllers/CategoriesScreen_controller.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CategoriesController controller = Get.put(CategoriesController());
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SlideInUp(
          child: Row(
            children: [
              // Display only the first 2 categories
              ...List.generate(
                controller.categories.length < 2
                    ? controller.categories.length
                    : 2,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0
                        ? AppConstants.defaultPadding
                        : AppConstants.defaultPadding / 2,
                    right: 0, // No right padding for the first two items
                  ),
                  child: CategoryBtn(
                    image: controller.categories[index]['image'],
                    category: controller.categories[index]['name'],
                    press: () {
                      Get.toNamed(
                        AppRoutes.categoryDetails,
                        arguments: {
                          'categoryId': controller.categories[index]['id'],
                        },
                      );
                    },
                  ),
                ),
              ),
              // Add the "View All" button with a "+" icon
              Padding(
                padding: const EdgeInsets.only(
                  left: AppConstants.defaultPadding / 2,
                  right: AppConstants.defaultPadding,
                ),
                child: InkWell(
                  onTap: () {
                    // Navigate to a screen that shows all categories
                    Get.toNamed(AppRoutes.categoriesScreen);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Container(
                    height: 85.h,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.defaultPadding),
                    decoration: BoxDecoration(
                        color: AppColors.transparentColor,
                        border:
                            Border.all(color: Theme.of(context).dividerColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 30.sp,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryBtn extends StatelessWidget {
  const CategoryBtn(
      {super.key,
      required this.category,
      required this.press,
      required this.image});

  final String category;
  final VoidCallback press;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 85.h,
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        decoration: BoxDecoration(
            color: AppColors.transparentColor,
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Image.network(
                image,
                width: 50.w,
                height: 50.h,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5.h),
              Text(
                category,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
