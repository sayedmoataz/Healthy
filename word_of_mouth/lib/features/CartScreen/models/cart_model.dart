class CartModel {
  final String name;
  final String? descripation;
  final String image;
  final double price;
  final double? priceAfterDiscount;
  final int quantity;

  CartModel({
    required this.name, 
    required this.image,
    required this.price, 
    required this.quantity,
    this.descripation,
    this.priceAfterDiscount
  });
}
