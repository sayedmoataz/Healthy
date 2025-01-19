import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/services/validator_helper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../widgets/custom_text_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstants.defaultPadding,
          children: [
            const SizedBox(height: AppConstants.defaultPadding * 3),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  AppAssets.arrowLeft,
                  colorFilter: const ColorFilter.mode(
                    AppColors.blackColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              AppStrings.recoveryPassword,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Text(AppStrings.recoveryPasswordDescription),
            CustomTextField(
              controller: emailController,
              onSaved: (emal) {},
              validator: Validators.emaildValidator.call,
              keyboardType: TextInputType.emailAddress,
              hintText: AppStrings.email,
              assetName: AppAssets.emailIcon,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                
              },
              child: const Text(AppStrings.login),
            ),
          ],
        ),
      ),
    );
  }
}
