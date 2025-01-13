import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../HomeScreen/view/widgets/offers_carousel.dart';
import '../../controllers/Product_screen_controller.dart';
import '../widgets/quantity_selector.dart';

class ProductScreenPage extends GetView<ProductScreenController> {
    
    const ProductScreenPage({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
        return Scaffold(
      body: SafeArea(
        child: Column(
                children: [
                  OffersCarousel(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.defaultPadding),
                      child: Text(
                        'controller.product.name',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.defaultPadding),
                      child: Text(
                        'controller.product.name\ncontroller.product.name\tcontroller.product.name\tcontroller.product.name\ncontroller.product.name',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  QuantitySelector(),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (){}, 
                    child: const Text(AppStrings.addToCart),
                  )                  
                ],
              ),
      )
        );
    }
}