import 'package:get/get.dart';

import '../../../features/AllOrdersScreen/controller/AllOrdersScreen_bindings.dart';
import '../../../features/AllOrdersScreen/views/pages/AllOrdersScreen_page.dart';
import '../../../features/CartScreen/controllers/CartScreen_bindings.dart';
import '../../../features/CartScreen/view/pages/CartScreen_page.dart';
import '../../../features/CategoriesScreen/controllers/CategoriesScreen_bindings.dart';
import '../../../features/CategoriesScreen/controllers/category_details_controller.dart';
import '../../../features/CategoriesScreen/view/pages/CategoriesScreen_page.dart';
import '../../../features/CategoriesScreen/view/pages/category_details.dart';
import '../../../features/InfoScreen/controllers/InfoScreen_bindings.dart';
import '../../../features/InfoScreen/views/pages/InfoScreen_page.dart';
import '../../../features/InfoScreen/views/pages/menu_screen/about_us.dart';
import '../../../features/InfoScreen/views/pages/menu_screen/contact_us.dart';
import '../../../features/InfoScreen/views/pages/menu_screen/edit_profile.dart';
import '../../../features/InfoScreen/views/pages/menu_screen/faq.dart';
import '../../../features/InfoScreen/views/pages/menu_screen/privacy_policy.dart';
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
      page: () => LoginPage(),
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
      name: AppRoutes.productScreen,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        if (args == null ||
            args['productId'] == null ||
            args['collectionName'] == null) {
          throw ArgumentError('productId and collectionName must be provided');
        }
        return ProductScreenPage(
          productId: args['productId'] as String,
          collectionName: args['collectionName'] as String,
        );
      },
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
      name: AppRoutes.categoryDetails,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        if (args == null || args['categoryId'] == null) {
          throw ArgumentError('categoryId must be provided');
        }
        return CategoryDetails(categoryId: args['categoryId'] as String);
      },
      binding: BindingsBuilder(() {
        final args = Get.arguments as Map<String, dynamic>?;
        if (args == null || args['categoryId'] == null) {
          throw ArgumentError('categoryId must be provided');
        }
        Get.put(CategoryDetailsController(
            categoryId: args['categoryId'] as String));
      }),
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
    GetPage(
      name: AppRoutes.editProfileScreen,
      page: () => const EditProfileScreen(),
      binding: InfoScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.aboutUsScreen,
      page: () => const AboutUsScreen(),
      binding: InfoScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.faqScreen,
      page: () => const FAQScreen(),
      binding: InfoScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.contactUsScreen,
      page: () => const ContactUsScreen(),
      binding: InfoScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.privacyPolicyScreen,
      page: () => const PrivacyPolicyScreen(),
      binding: InfoScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.allOrdersScreen,
      page: () => const AllOrdersScreenPage(),
      binding: AllOrdersScreenBindings(),
    ),
  ];
}
