import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';

class ProductModel {
  final String image, title;
  final int? price;
  final int? priceAfetDiscount;
  final int? dicountpercent;

  ProductModel({
    required this.image,
    required this.title,
    required this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
  });
}

List<ProductModel> demoPopularProducts = [
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
];
List<ProductModel> demoFlashSaleProducts = [
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
];
List<ProductModel> demoBestSellersProducts = [
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
];
List<ProductModel> kidsProducts = [
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
  ProductModel(
    image: AppAssets.networkImage,
    title: AppStrings.appName,
    price: 100,
    priceAfetDiscount: 89,
    dicountpercent: 11,
  ),
];
