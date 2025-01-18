import 'package:flutter/material.dart';

import '../../../features/onboarding/view/pages/on_boaerding.dart';

class AppRoutes {
  //? Routes as a widget
  static Widget get onBoarding => OnBoarding();

  //? Routes as a string
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/LoginScreen';
  static const String signUp = '/signUp';
  static const String landingScreen = '/landingScreen';
  static const String homeScreen = '/homeScreen';
  static const String forgetPassword = '/forgetPassword';
  static const String productScreen = '/productScreen';
  static const String categoriesScreen = '/categoriesScreen';
}
