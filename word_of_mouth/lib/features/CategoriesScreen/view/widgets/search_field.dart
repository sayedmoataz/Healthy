import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../controllers/CategoriesScreen_controller.dart';

class CustomSearchField extends StatelessWidget {
  final CategoriesScreenController controller;
  const CustomSearchField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGreyColor,
          borderRadius:
              BorderRadius.circular(AppConstants.defaultBorderRadious),
        ),
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(AppConstants.defaultPadding),
              child: Icon(Icons.search, color: AppColors.greyColor),
            ),
            Expanded(
              child: TextField(
                // onChanged: controller.updateSearch,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: AppStrings.findSomeThing,
                  hintStyle: TextStyle(color: AppColors.darkGreyColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
