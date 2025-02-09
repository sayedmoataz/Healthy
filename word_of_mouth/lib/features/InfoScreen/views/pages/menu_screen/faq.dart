import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/components/custom_app_bar.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../controllers/InfoScreen_controller.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InfoScreenController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: AppStrings.faq, backable: true),
            Expanded(
              child: Obx(() {
                if (controller.isFaqLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.faqs.isEmpty) {
                  return const Center(child: Text('No FAQs available'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: controller.faqs.length,
                  itemBuilder: (context, index) {
                    var faq = controller.faqs[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          faq['question']!,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          faq['answer']!,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Divider(thickness: 1, height: 20),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
