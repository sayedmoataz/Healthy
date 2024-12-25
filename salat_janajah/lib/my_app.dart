import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/route/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';
import 'core/widgets/offline_widget.dart';
import 'features/splashScreen/presentation/pages/splash_screen.dart';

class MyAppRoot extends StatelessWidget {
  const MyAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widget) {
          return MediaQuery.withNoTextScaling(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              theme: appTheme(),
              color: AppColors.primaryColor,
              initialRoute: '/',
              onGenerateRoute: AppRoutes.onGeneratedRoute,
              home: OfflineBuilder(
                  connectivityBuilder: (
                    BuildContext context,
                    List<ConnectivityResult> connectivity,
                    Widget child,
                  ) {
                    final bool connected = connectivity.contains(ConnectivityResult.none);
                    if (connected) {
                      return const SplashScreen();
                    } else {
                      return const OfflineWidget();
                    }
                  },
                  child: Center(
                      child: CircularProgressIndicator(
                          color: AppColors.secondaryColor))),
            ),
          );
        });
  }
}
