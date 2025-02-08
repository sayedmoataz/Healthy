import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';

class LoadingButton extends StatelessWidget {
  final String label;
  final RxBool isLoading;
  final VoidCallback onPressed;

  const LoadingButton({
    super.key,
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: isLoading.value ? null : onPressed,
        child: isLoading.value
            ? CircularProgressIndicator(color: AppColors.whiteColor)
            : Text(label),
      ),
    );
  }
}
