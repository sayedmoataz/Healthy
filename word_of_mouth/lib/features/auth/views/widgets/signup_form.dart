import 'package:flutter/material.dart';

import '../../../../core/services/validator_helper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import 'custom_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
    return Form(
      key: _signupFormKey,
      child: Column(
        children: [
          CustomTextField(
            onSaved: (emal) {},
            validator: Validators.emaildValidator.call,
            keyboardType: TextInputType.emailAddress,
            hintText: AppStrings.email,
            assetName: AppAssets.emailIcon,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          CustomTextField(
            onSaved: (pass) {},
            validator: Validators.passwordValidator.call,
            hintText: AppStrings.password,
            assetName: AppAssets.passwordIcon,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          CustomTextField(
            onSaved: (pass) {},
            validator: Validators.passwordValidator.call,
            hintText: AppStrings.confirmPassword,
            assetName: AppAssets.passwordIcon,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }
}