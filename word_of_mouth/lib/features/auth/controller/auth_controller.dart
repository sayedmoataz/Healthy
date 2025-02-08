// class AuthController extends GetxController {
//   var isLoading = false.obs;
//   Future<void> signUp({
//     required String email,
//     required String mobileNumber,
//     required String firstName,
//     required String lastName,
//     required String password,
//   }) async {
//     isLoading.value = true;
//     try {
//       final response = await HttpHelper.postData(
//         endpoint: EndPoints.Register,
//         data: {
//           'email': email,
//           'mobileNumber': mobileNumber,
//           'firstName': firstName,
//           'lastName': lastName,
//           'password': password,
//         },
//       );
//       if (response.statusCode == 201) {
//         json.decode(response.body);
//         Get.snackbar('Success', 'Account created successfully!',
//             snackPosition: SnackPosition.BOTTOM);
//         log('sign up res is: ${response.body}');
//         await login(email: email, password: password);
//       } else {
//         final errorData = json.decode(response.body);
//         final errorMessage = errorData['message'] ?? 'An error occurred during sign up.';
//         log('sign up error is: ${response.body}');
//         Get.snackbar('Error', errorMessage,
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       log('sign up error is: $e');
//       Get.snackbar('Error', 'An error occurred: $e',
//           snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   Future<void> login({
//     required String email,
//     required String password,
//   }) async {
//     isLoading.value = true;
//     try {
//       final response = await HttpHelper.postData(
//         endpoint: EndPoints.Login,
//         data: {
//           'email': email,
//           'password': password,
//         },
//       );
//       if (response.statusCode == 201) {
//         final responseData = json.decode(response.body);
//         final accessToken = responseData['access_token'];
//         CacheHelper.putData(key: AppConstants.userToken, value: accessToken);
//         Get.snackbar('Success', 'Login successfully!',
//             snackPosition: SnackPosition.BOTTOM);
//         Get.offAllNamed(AppRoutes.landingScreen);
//       } else {
//         final errorData = json.decode(response.body);
//         final errorMessage = errorData['message'] ?? 'An error occurred during login.';
//         log('login error is: ${response.body}');
//         Get.snackbar('Error', errorMessage,
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       log('login error is: $e');
//       Get.snackbar('Error', 'An error occurred: $e',
//           snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_snack_bar.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/utils/routing/app_routes.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp({
    required String email,
    required String mobileNumber,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName('$firstName $lastName');
        CommonUI.showSnackBar('Account created successfully!');
        await login(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      CommonUI.showSnackBar(e.message ?? 'An error occurred during sign up.');
    } catch (e) {
       CommonUI.showSnackBar('An error occurred during sign up.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        String? token = await user.getIdToken();
        log('token is: $token');
        await CacheHelper.putData(key: 'userToken', value: token);
         CommonUI.showSnackBar('Login successfully!');
        Get.offAllNamed(AppRoutes.landingScreen);
      }
    } on FirebaseAuthException catch (e) {
      CommonUI.showSnackBar(e.message ?? 'An error occurred during login.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await CacheHelper.deleteData(key: 'userToken');
    CommonUI.showSnackBar('Logout successfully!');
    Get.offAllNamed(AppRoutes.loginScreen);
  }
}
