import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  TextEditingController controller;
  String? hintText;
  String assetName;
  int? maxLine;
  bool? enabled;
  CustomTextField({
    this.onSaved,
    this.validator,
    this.keyboardType,
    required this.controller,
    this.hintText,
    required this.assetName,
    this.maxLine,
    this.enabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      validator: validator,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      // obscureText: keyboardType == TextInputType.visiblePassword,
      obscureText: hintText == AppStrings.password,
      maxLines: keyboardType != TextInputType.visiblePassword ? maxLine : 1,
      decoration: InputDecoration(
        enabled: enabled ?? true,
        disabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppConstants.defaultBorderRadious),
        ),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppConstants.defaultBorderRadious),
        ),
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppConstants.defaultPadding * 0.75),
          child: SvgPicture.asset(
            assetName,
            height: 24.h,
            width: 24.w,
            colorFilter: ColorFilter.mode(
              Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withValues(alpha: 0.3),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
