import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';
import 'core/utils/theme/app_theme.dart';
import 'core/utils/routing/app_pages.dart';
import 'features/splash_screen/splash_screen.dart';

class MyAppRoot extends StatelessWidget {
  const MyAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widget) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: appTheme(),
            color: AppColors.primaryColor,
            home: const SpalshScreen(),
            getPages: AppPages.routes,
          );
        });
  }
}
