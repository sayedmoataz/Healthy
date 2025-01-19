import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/custom_app_bar.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../auth/views/widgets/custom_text_field.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding / 2),
        child: Column(
          children: [
            const CustomAppBar(title: AppStrings.contactUs),
            CustomTextField(
              controller: nameController,
              assetName: AppAssets.passwordIcon,
              // validator: Validators.validationNull(controller.nameController.text),
              hintText: 'Message',
              maxLine: 5,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(onPressed: () {}, child: const Text('Send')),
          ],
        ),
      )),
    );
  }
}
