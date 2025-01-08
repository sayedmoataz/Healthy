import 'package:flutter/material.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/routing/app_routes.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      backgroundColor: AppColors.whiteColor,
      navigateWhere: true,
      duration: const Duration(milliseconds: 3500),
      navigateRoute: AppRoutes.onBoarding,
      imageSrc: AppAssets.logo,
    );
  }
}
