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
          child: Column(
            children: [
              const CustomAppBar(title: AppStrings.editProfile, backable: true),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: 100.w,
                  height: 100.h,
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.greyColor,
                        width: 1,
                      ),
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(AppAssets.networkImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: controller.nameController,
                assetName: AppAssets.passwordIcon,
                // validator: Validators.validationNull(controller.nameController.text),
                hintText: 'Name',
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: controller.nameController,
                assetName: AppAssets.passwordIcon,
                // validator: Validators.validationNull(controller.nameController.text),
                hintText: 'Email',
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: controller.nameController,
                assetName: AppAssets.passwordIcon,
                // validator: Validators.validationNull(controller.nameController.text),
                hintText: 'Address',
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: controller.nameController,
                assetName: AppAssets.passwordIcon,
                // validator: Validators.validationNull(controller.nameController.text),
                hintText: 'Phone',
              ),
              SizedBox(height: 20.h),
              ElevatedButton(onPressed: () {}, child: const Text('Save')),
            ],
          )),
    );
  }
}
