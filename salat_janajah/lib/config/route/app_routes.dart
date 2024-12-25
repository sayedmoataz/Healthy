import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';
import '../../features/splashScreen/presentation/pages/splash_screen.dart';


class Routes {
  static const String initialRoute = '/';
}

class AppRoutes {
  static Route? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
                body: Center(
              child: Text(AppStrings.noRoutesFound),
            ))));
  }
}