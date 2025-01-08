import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/components/dot_indicators.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/routing/app_routes.dart';
import '../../controller/onboarding_controller.dart';
import '../widgets/onboarding_widget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final _controller = OnboardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.offNamed(AppRoutes.loginScreen);
                  },
                  child: Text(
                    AppStrings.skip,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller.pageController,
                  itemCount: _controller.onboardingPages.length,
                  onPageChanged: (value) {
                    setState(() {
                      _controller.selectedPageIndex = value.obs;
                    });
                  },
                  itemBuilder: (context, index) => OnbordingContent(
                    title: _controller.onboardingPages[index].title,
                    description: _controller.onboardingPages[index].description,
                    image: _controller.onboardingPages[index].image,
                    isTextOnTop: index.isOdd,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    _controller.onboardingPages.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                          right: AppConstants.defaultPadding / 4),
                      child: DotIndicator(
                          isActive:
                              index == _controller.selectedPageIndex.value),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
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
                ],
              ),
              const SizedBox(height: AppConstants.defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
