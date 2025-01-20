import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/services/cache_helper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../controller/onboarding_controller.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);

  final OnboardingController _controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60.h,
        width: 60.w,
        child: ElevatedButton(
          onPressed: () => _controller.nextAction(),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
          ),
          child: SvgPicture.asset(
            AppAssets.arrowRight,
            colorFilter: ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // PageView without Obx wrapper
          PageView.builder(
            controller: _controller.pageController,
            itemCount: _controller.onboardingPages.length,
            onPageChanged: (value) {
              _controller.selectedPageIndex.value = value;
            },
            itemBuilder: (context, index) {
              final page = _controller.onboardingPages[index];
              return Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.asset(
                      page.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Dark overlay
                  Positioned.fill(
                    child: Container(
                      color: AppColors.blackColor.withValues(alpha: 0.5),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.defaultPadding),
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              CacheHelper.putData(
                                  key: AppConstants.skipOnBoarding, value: true);
                              Get.offNamed(AppRoutes.loginScreen);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppConstants.defaultBorderRadious),
                              ),
                            ),
                            child: Text(
                              AppStrings.skip,
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.0.h),
                                child: Column(
                                  children: [
                                    Text(
                                      page.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(color: AppColors.whiteColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      page.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: AppColors.whileColor80),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppConstants.defaultPadding),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
