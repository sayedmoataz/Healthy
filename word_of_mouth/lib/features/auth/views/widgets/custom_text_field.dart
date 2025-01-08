import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  String? hintText;
  String assetName;
  CustomTextField({
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.hintText,
    required this.assetName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      obscureText: keyboardType == TextInputType.visiblePassword,
      decoration: InputDecoration(
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
