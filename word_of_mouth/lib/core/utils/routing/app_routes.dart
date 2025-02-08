import 'package:flutter/material.dart';

import '../../../features/NavigationBar/views/NavigationBar_page.dart';
import '../../../features/auth/views/pages/login.dart';
import '../../../features/onboarding/view/pages/on_boaerding.dart';

class AppRoutes {
  //? Routes as a widget
  static Widget get onBoardingScreen => OnBoarding();
  static Widget get LoginScreen => LoginPage();
  static Widget get LandingWidget => const LandingScreen();

  //? Routes as a string
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/LoginScreen';
  static const String signUp = '/signUp';
  static const String landingScreen = '/landingScreen';
  static const String homeScreen = '/homeScreen';
  static const String forgetPassword = '/forgetPassword';
  static const String productScreen = '/productScreen';
  static const String categoriesScreen = '/categoriesScreen';
  static const String categoryDetails = '/categoryDetails';
  static const String cartScreen = '/cartScreen';
  static const String infoScreen = '/infoScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String faqScreen = '/faqScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String allOrdersScreen = '/allOrdersScreen';
}
