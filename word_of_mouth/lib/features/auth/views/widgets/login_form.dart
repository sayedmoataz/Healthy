import 'package:flutter/material.dart';

import '../../../../core/services/validator_helper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import 'custom_text_field.dart';

class LogInForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LogInForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            validator: Validators.emaildValidator.call,
            keyboardType: TextInputType.emailAddress,
            hintText: AppStrings.email,
            assetName: AppAssets.emailIcon,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          CustomTextField(
            controller: passwordController,
            validator: Validators.passwordValidator.call,
            hintText: AppStrings.password,
            assetName: AppAssets.passwordIcon,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }
}

