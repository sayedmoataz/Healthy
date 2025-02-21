import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../controllers/InfoScreen_controller.dart';

class InfoScreenPage extends GetView<InfoScreenController> {
  const InfoScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'Menu', backable: false),
          SizedBox(height: 20.sp),
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius:
                  BorderRadius.circular(AppConstants.defaultBorderRadious),
              border: Border.all(color: AppColors.greyColor),
            ),
            child: Column(
              children: [
                ListTile(
                  title: const Text(AppStrings.editProfile),
                  onTap: () => Get.toNamed(AppRoutes.editProfileScreen),
                ),
                const Divider(),
                ListTile(
                  title: const Text(AppStrings.aboutUs),
                  onTap: () => Get.toNamed(AppRoutes.aboutUsScreen),
                ),
                const Divider(),
                ListTile(
                  title: const Text(AppStrings.faq),
                  onTap: () => Get.toNamed(AppRoutes.faqScreen),
                ),
                const Divider(),
                ListTile(
                  title: const Text(AppStrings.contactUs),
                  onTap: () => Get.toNamed(AppRoutes.contactUsScreen),
                ),
                const Divider(),
                ListTile(
                  title: const Text(AppStrings.privacyPolicy),
                  onTap: () => Get.toNamed(AppRoutes.privacyPolicyScreen),
                ),
                const Divider(),
                ListTile(
                  title: const Text(AppStrings.rateUs),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: const Text(AppStrings.shareApp),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: const Text(AppStrings.logout),
                  onTap: () {
                    AuthController authController = Get.put(AuthController());
                    authController.logout();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
