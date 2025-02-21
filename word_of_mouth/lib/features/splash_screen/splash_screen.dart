
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import '../../core/services/cache_helper.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/routing/app_routes.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      backgroundColor: AppColors.whiteColor,
      navigateWhere: true,
      duration: const Duration(milliseconds: 3500),
      navigateRoute: _navigatorScreen(),
      imageSrc: AppAssets.logo,
    );
  }

  Widget _navigatorScreen() {
    final bool? skipOnBoarding = CacheHelper.getData(key: AppConstants.skipOnBoarding) as bool?;
    final String? token = CacheHelper.getData(key: AppConstants.userToken) as String?;
    log('token is: $token');

    return (skipOnBoarding == null || skipOnBoarding == false)
        ? AppRoutes.onBoardingScreen
        : (token == null || token.isEmpty)
            ? AppRoutes.LoginScreen
            : AppRoutes.LandingWidget;
  }
}
