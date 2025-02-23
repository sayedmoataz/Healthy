import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/components/products/product_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../controllers/Product_screen_controller.dart';
import '../widgets/product_carousel.dart';

// class ProductScreenPage extends GetView<ProductScreenController> {
//   final String productId;
//   final String collectionName;

//   const ProductScreenPage({
//     Key? key,
//     required this.productId,
//     required this.collectionName,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const CustomAppBar(title: '', backable: true),
//               Obx(() {
//                 if (controller.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 var product = controller.product.value;
//                 return Column(
//                   children: [
//                     if (product['images'] != null && product['images'].isNotEmpty)
//                       ProductCarousel(
//                         images: product['images'],
//                         onPageChanged: (index) {},
//                       ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: const EdgeInsets.all(AppConstants.defaultPadding),
//                         child: Text(
//                           product['name'] ?? 'No name available',
//                           style: TextStyle(
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.blackColor80,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: const EdgeInsets.all(AppConstants.defaultPadding),
//                         child: Text(
//                           product['description'] ?? 'No description available',
//                           textAlign: TextAlign.right,
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.blackColor60,
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Sizes Selection
//                     if (product['sizes'] != null)
//                       _buildSizesSection(product['sizes']),

//                     // Quantity Selection
//                     _buildQuantitySelector(),

//                     // Add to Cart Section with Total Price
//                     _buildAddToCartSection(product),

//                     // Related Products Section
//                     if (controller.relatedProducts.isNotEmpty)
//                       _buildRelatedProductsSection(context),
//                   ],
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSizesSection(List<dynamic> sizes) {
//     return Padding(
//       padding: const EdgeInsets.all(AppConstants.defaultPadding),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             'اختر المقاس',
//             style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.bold,
//               color: AppColors.blackColor,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: sizes.map((size) => Obx(() {
//               bool isSelected = controller.selectedSize.value == size;
//               return InkWell(
//                 onTap: () => controller.selectSize(size),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: isSelected ? AppColors.primaryColor : AppColors.blackColor20,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                     color: isSelected ? AppColors.primaryColor : Colors.transparent,
//                   ),
//                   child: Text(
//                     size.toString(),
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : AppColors.blackColor80,
//                     ),
//                   ),
//                 ),
//               );
//             })).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuantitySelector() {
//     return Padding(
//       padding: const EdgeInsets.all(AppConstants.defaultPadding),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.blackColor20),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.remove),
//                   onPressed: controller.decrement,
//                 ),
//                 Obx(() => Text(
//                   controller.quantity.value.toString(),
//                   style: TextStyle(fontSize: 18.sp),
//                 )),
//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: controller.increment,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 16),
//           Text(
//             'الكمية:',
//             style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddToCartSection(Map<String, dynamic> product) {
//     return Padding(
//       padding: const EdgeInsets.all(AppConstants.defaultPadding),
//       child: Row(
//         children: [
//           Expanded(
//             child: Obx(() => controller.isAddingToCart.value
//               ? const Center(child: CircularProgressIndicator())
//               : ElevatedButton(
//                   onPressed: () => _handleAddToCart(product),
//                   child: const Text(AppStrings.addToCart),
//                 ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Obx(() => Text(
//             '${(product['priceAfter'] as num? ?? 0) * controller.quantity.value} SAR',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: AppColors.primaryColor,
//             ),
//           )),
//         ],
//       ),
//     );
//   }

//   Future<void> _handleAddToCart(Map<String, dynamic> product) async {
//     if (product['sizes'] != null && controller.selectedSize.value.isEmpty) {
//       CommonUI.showSnackBar('الرجاء اختيار المقاس');
//       return;
//     }

//     await controller.addToCart(
//       productId: productId,
//       productName: product['name'],
//       price: (product['priceAfter'] as num?)?.toDouble() ?? 0,
//       quantity: controller.quantity.value,
//       size: controller.selectedSize.value,
//       image: product['images'] != null && product['images'].isNotEmpty
//           ? product['images'][0]
//           : AppAssets.networkImage,
//     );

//     Get.dialog(
//       AlertDialog(
//         title: const Text('تمت الإضافة للسلة'),
//         content: const Text('هل تريد الاستمرار في التسوق أم الذهاب إلى السلة؟'),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('متابعة التسوق'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               Get.toNamed(AppRoutes.cartScreen);
//             },
//             child: const Text('الذهاب للسلة'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRelatedProductsSection(BuildContext context) {
//     return Column(
//       children: [
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.all(AppConstants.defaultPadding),
//             child: Text(
//               AppStrings.relatedProducts,
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 150.h,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: controller.relatedProducts.length,
//             itemBuilder: (context, index) {
//               var relatedProduct = controller.relatedProducts[index];
//               return Padding(
//                 padding: EdgeInsets.only(
//                   left: AppConstants.defaultPadding,
//                   right: index == controller.relatedProducts.length - 1
//                       ? AppConstants.defaultPadding
//                       : 0,
//                 ),
//                 child: ProductCard(
//                   image: (relatedProduct['images'] != null &&
//                           relatedProduct['images'].isNotEmpty)
//                       ? relatedProduct['images'][0]
//                       : 'default_image_url',
//                   title: relatedProduct['name'] ?? 'Unknown Product',
//                   price: (relatedProduct['priceBefore'] as num?)?.toInt() ?? 0,
//                   priceAfetDiscount:
//                       (relatedProduct['priceAfter'] as num?)?.toInt(),
//                   dicountpercent:
//                       (relatedProduct['discount'] as num?)?.toInt(),
//                   press: () {
//                     controller.loadProductDetails(
//                       relatedProduct['id'],
//                       collectionName,
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

class ProductScreenPage extends GetView<ProductScreenController> {
  final String productId;
  final String collectionName;

  const ProductScreenPage({
    Key? key,
    required this.productId,
    required this.collectionName,
  }) : super(key: key);

  // Define fixed values for sizes and quantities
  static const List<String> fixedSizes = ['S', 'M', 'L'];
  static const List<int> fixedQuantities = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(title: '', backable: true),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                var product = controller.product.value;
                return Column(
                  children: [
                    if (product['images'] != null &&
                        product['images'].isNotEmpty)
                      ProductCarousel(
                        images: product['images'],
                        onPageChanged: (index) {},
                      ),
                    _buildProductDetails(product),
                    _buildSizesAndQuantitySection(),
                    _buildAddToCartSection(product),
                    if (controller.relatedProducts.isNotEmpty)
                      _buildRelatedProductsSection(context),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(Map<String, dynamic> product) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            product['name'] ?? 'No name available',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor80,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            product['description'] ?? 'No description available',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor60,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds Sizes & Quantity in a horizontal row.
  Widget _buildSizesAndQuantitySection() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildSizeSelector(),
            _buildQuantitySelector(),
          ],
        ),
      ),
    );
  }

  /// Builds the Sizes selection as a list of tappable containers.
  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'اختر المقاس',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: fixedSizes.map((size) {
            return Obx(() {
              bool isSelected = controller.selectedSize.value == size;
              return _buildSelectableContainer(
                text: size,
                isSelected: isSelected,
                onTap: () => controller.selectSize(size),
              );
            });
          }).toList(),
        ),
      ],
    );
  }

  /// Builds the Quantity selection as a list of tappable containers.
  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'الكمية',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: fixedQuantities.map((qty) {
            return Obx(() {
              bool isSelected = controller.quantity.value == qty;
              return _buildSelectableContainer(
                text: qty.toString(),
                isSelected: isSelected,
                onTap: () => controller.selectQuantity(qty),
              );
            });
          }).toList(),
        ),
      ],
    );
  }

  /// Reusable method to build selectable containers for Size & Quantity.
  Widget _buildSelectableContainer({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.blackColor20,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            color: isSelected ? Colors.white : AppColors.blackColor80,
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCartSection(Map<String, dynamic> product) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => controller.isAddingToCart.value
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () => controller.handleAddToCart(product),
                      child: const Text(AppStrings.addToCart),
                    ),
            ),
          ),
          const SizedBox(width: 16),
          Obx(() => Text(
                '${(product['priceAfter'] as num? ?? 0) * controller.quantity.value} EGP',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildRelatedProductsSection(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Text(
              AppStrings.relatedProducts,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        SizedBox(
          height: 150.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.relatedProducts.length,
            itemBuilder: (context, index) {
              var relatedProduct = controller.relatedProducts[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: AppConstants.defaultPadding,
                  right: index == controller.relatedProducts.length - 1
                      ? AppConstants.defaultPadding
                      : 0,
                ),
                child: ProductCard(
                  image: (relatedProduct['images'] != null &&
                          relatedProduct['images'].isNotEmpty)
                      ? relatedProduct['images'][0]
                      : 'default_image_url',
                  title: relatedProduct['name'] ?? 'Unknown Product',
                  price: (relatedProduct['priceBefore'] as num?)?.toInt() ?? 0,
                  priceAfetDiscount:
                      (relatedProduct['priceAfter'] as num?)?.toInt(),
                  dicountpercent: (relatedProduct['discount'] as num?)?.toInt(),
                  press: () {
                    controller.loadProductDetails(
                      relatedProduct['id'],
                      collectionName,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
