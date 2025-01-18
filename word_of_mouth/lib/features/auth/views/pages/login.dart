import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AppAssets.logo,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.welcom,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppConstants.defaultPadding / 2),
                    const Text(AppStrings.makeLogin),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const LogInForm(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: const Text(AppStrings.forgetPassword),
                        onPressed: () => Get.toNamed(AppRoutes.forgetPassword),
                      ),
                    ),
                    SizedBox(
                      height: size.height > 700
                          ? size.height * 0.1
                          : AppConstants.defaultPadding,
                    ),
                    ElevatedButton(
                      onPressed: () => Get.toNamed(AppRoutes.landingScreen),
                      child: const Text(AppStrings.login),
                    ),
                    SizedBox(height: 5.h),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: AppStrings.haveAccount,
                          style: const TextStyle(color: AppColors.blackColor40),
                          children: [
                            TextSpan(
                              text: AppStrings.signUp,
                              style: const TextStyle(
                                  color: AppColors.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.signUp);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
