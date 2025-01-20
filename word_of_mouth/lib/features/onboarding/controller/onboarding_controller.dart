import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/cache_helper.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/routing/app_routes.dart';
import '../model/onboarding_model.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  late PageController pageController;
  bool get isFirstPage => selectedPageIndex.value == 0;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextAction() {
    if (isLastPage) {
      CacheHelper.putData(key: AppConstants.skipOnBoarding,value: true);
      Get.offNamed(AppRoutes.loginScreen);
    } else {
      pageController.nextPage(
        duration: AppConstants.defaultDuration,
        curve: Curves.ease,
      );
    }
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo(
      image: AppAssets.onboarding[0],
      title: AppStrings.onBoardingTitles[0],
      description: AppStrings.onBoardingDescriptions[0],
    ),
    OnboardingInfo(
      image: AppAssets.onboarding[1],
      title: AppStrings.onBoardingTitles[1],
      description: AppStrings.onBoardingDescriptions[1],
    ),
    OnboardingInfo(
      image: AppAssets.onboarding[2],
      title: AppStrings.onBoardingTitles[2],
      description: AppStrings.onBoardingDescriptions[2],
    ),
    OnboardingInfo(
      image: AppAssets.onboarding[3],
      title: AppStrings.onBoardingTitles[3],
      description: AppStrings.onBoardingDescriptions[3],
    ),
    OnboardingInfo(
      image: AppAssets.onboarding[4],
      title: AppStrings.onBoardingTitles[4],
      description: AppStrings.onBoardingDescriptions[4],
    ),
  ];
}
