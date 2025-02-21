import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/components/custom_app_bar.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../auth/views/widgets/custom_text_field.dart';
import '../../../controllers/InfoScreen_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    InfoScreenController controller = Get.find();
    
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomAppBar(title: AppStrings.editProfile, backable: true),
                SizedBox(height: 20.h),

                // Profile Image
                Center(
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyColor, width: 1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(controller.profileImage.value.isNotEmpty
                            ? controller.profileImage.value
                            : AppAssets.networkImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // First Name
                CustomTextField(
                  controller: controller.firstNameController,
                  assetName: AppAssets.emailIcon,
                  hintText: 'First Name',
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 20.h),

                // Last Name
                CustomTextField(
                  controller: controller.lastNameController,
                  assetName: AppAssets.emailIcon,
                  hintText: 'Last Name',
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 20.h),

                // Email (Disabled)
                CustomTextField(
                  controller: controller.emailController,
                  assetName: AppAssets.emailIcon,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  enabled: false,
                ),
                SizedBox(height: 20.h),

                // Phone Number
                CustomTextField(
                  controller: controller.phoneController,
                  assetName: AppAssets.passwordIcon,
                  hintText: 'Phone',
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20.h),

                // Street Address
                CustomTextField(
                  controller: controller.streetController,
                  assetName: AppAssets.passwordIcon,
                  hintText: 'Street',
                ),
                SizedBox(height: 20.h),

                // City
                CustomTextField(
                  controller: controller.cityController,
                  assetName: AppAssets.passwordIcon,
                  hintText: 'City',
                ),
                SizedBox(height: 20.h),

                // State
                CustomTextField(
                  controller: controller.stateController,
                  assetName: AppAssets.passwordIcon,
                  hintText: 'State',
                ),
                SizedBox(height: 20.h),

                // Zip Code
                CustomTextField(
                  controller: controller.zipCodeController,
                  assetName: AppAssets.passwordIcon,
                  hintText: 'Zip Code',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.h),

                // Country
                CustomTextField(
                  controller: controller.countryController,
                  assetName: AppAssets.passwordIcon,
                  hintText: 'Country',
                ),
                SizedBox(height: 20.h),

                // Save Button
                ElevatedButton(
                  onPressed: () => controller.editProfile(),
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

