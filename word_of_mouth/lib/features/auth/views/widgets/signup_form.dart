import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/validator_helper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../controller/auth_controller.dart';
import 'auth_button.dart';
import 'custom_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final AuthController authController = Get.put(AuthController());

  final _signupFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cityController = TextEditingController();

  List<String> cities = [
    'Nasr City - Cairo',
    'Maadi - Cairo',
    'AlHaram -Giza',
    'Mansoura',
    'Aswan'
  ];

  Map<String, String> getFormData() {
    return {
      'email': _emailController.text,
      'mobileNumber': _mobileNumberController.text,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'password': _passwordController.text,
      'city': _cityController.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signupFormKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _firstNameController,
            validator: (value) => Validators.validationNull(
                value.toString(), AppStrings.firstName),
            keyboardType: TextInputType.name,
            hintText: AppStrings.firstName,
            assetName: AppAssets.emailIcon,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          CustomTextField(
            controller: _lastNameController,
            onSaved: (emal) {},
            validator: (value) => Validators.validationNull(
                value.toString(), AppStrings.lastName),
            keyboardType: TextInputType.name,
            hintText: AppStrings.lastName,
            assetName: AppAssets.emailIcon,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          CustomTextField(
            controller: _emailController,
            onSaved: (emal) {},
            validator: Validators.emaildValidator.call,
            keyboardType: TextInputType.emailAddress,
            hintText: AppStrings.email,
            assetName: AppAssets.emailIcon,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          CustomTextField(
            controller: _mobileNumberController,
            onSaved: (emal) {},
            validator: (value) => Validators.validationMobile(value.toString()),
            keyboardType: TextInputType.number,
            hintText: AppStrings.mobile,
            assetName: AppAssets.emailIcon,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          CustomTextField(
            controller: _passwordController,
            onSaved: (pass) {},
            validator: Validators.passwordValidator.call,
            hintText: AppStrings.password,
            assetName: AppAssets.passwordIcon,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          DropdownButtonFormField<String>(
            value: _cityController.text.isEmpty ? null : _cityController.text,
            onChanged: (String? newValue) {
              setState(() {
                _cityController.text = newValue!;
              });
            },
            items: cities.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(),
            ),
            validator: (value) => Validators.validationNull(
                value.toString(), 'City'),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Row(
            children: [
              Checkbox(
                onChanged: (value) {},
                value: false,
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: AppStrings.agreement,
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        text: AppStrings.terms,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(text: AppStrings.privacy),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding * 2),
          LoadingButton(
            label: AppStrings.signUp,
            isLoading: authController.isLoading,
            onPressed: () {
              if (_signupFormKey.currentState!.validate()) {
                _signupFormKey.currentState!.save();
                authController.signUp(
                  email: _emailController.text,
                  mobileNumber: _mobileNumberController.text,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  password: _passwordController.text,
                  city: _cityController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
