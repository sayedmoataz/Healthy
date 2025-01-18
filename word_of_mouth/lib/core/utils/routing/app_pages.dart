import 'package:get/get.dart';

import '../../../features/CartScreen/controllers/CartScreen_bindings.dart';
import '../../../features/CartScreen/view/pages/CartScreen_page.dart';
import '../../../features/CategoriesScreen/controllers/CategoriesScreen_bindings.dart';
import '../../../features/CategoriesScreen/view/pages/CategoriesScreen_page.dart';
import '../../../features/HomeScreen/view/pages/HomeScreen_page.dart';
import '../../../features/InfoScreen/controllers/InfoScreen_bindings.dart';
import '../../../features/InfoScreen/views/pages/InfoScreen_page.dart';
import '../../../features/NavigationBar/controller/NavigationBar_bindings.dart';
import '../../../features/NavigationBar/views/NavigationBar_page.dart';
import '../../../features/Product_screen/controllers/Product_screen_bindings.dart';
import '../../../features/Product_screen/view/pages/Product_screen_page.dart';
import '../../../features/auth/controller/auth_binding.dart';
import '../../../features/auth/views/pages/forget_password.dart';
import '../../../features/auth/views/pages/login.dart';
import '../../../features/auth/views/pages/sign_up.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();
  static final routes = [
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUp(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => const ForgetPassword(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.productScreen,
      page: () => const ProductScreenPage(),
      binding: ProductScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.landingScreen,
      page: () => const LandingScreen(),
      binding: NavigationBarBindings(),
    ),
    GetPage(
      name: AppRoutes.categoriesScreen,
      page: () => CategoriesScreenPage(),
      binding: CategoriesScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.cartScreen,
      page: () => const CartScreenPage(),
      binding: CartScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.infoScreen,
      page: () => const InfoScreenPage(),
      binding: InfoScreenBindings(),
    ),
  ];
}
