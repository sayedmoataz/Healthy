import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_assets.dart';
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
        height: 60,
        width: 60,
        child: ElevatedButton(
          onPressed: () => _controller.nextAction(),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
          ),
          child: SvgPicture.asset(
            AppAssets.arrowRight,
            colorFilter: const ColorFilter.mode(
              Colors.white,
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
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.defaultPadding),
                    child: Column(
                      children: [
                        SizedBox(height: 25.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.offNamed(AppRoutes.loginScreen);
                            },
                            child: Text(
                              AppStrings.skip,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      page.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      page.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white70),
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
