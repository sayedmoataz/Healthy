import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/custom_app_bar.dart';
import '../../../../../core/utils/app_strings.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: AppStrings.faq, backable: true),
              const Spacer(),
              Text(
                AppStrings.faq,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
            ],
          )),
    );
  }
}