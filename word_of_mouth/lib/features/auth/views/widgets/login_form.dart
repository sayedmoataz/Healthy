import 'package:flutter/material.dart';

import '../../../../core/services/validator_helper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import 'custom_text_field.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({super.key});

  @override
  Widget build(BuildContext context) {    
    final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    return Form(
      key: _loginFormKey,
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
        ],
      ),
    );
  }
}
