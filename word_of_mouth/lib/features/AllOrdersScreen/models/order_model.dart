class OrderModel {
  final String orderId;
  final String orderDate;
  final String status;
  final double total;
  // final int itemCount; // Changed to store the number of items
  final String customerName;
  final String paymentMethod;

  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.total,
    // required this.itemCount, // Store item count from list length
    required this.customerName,
    required this.paymentMethod,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      orderId: data['orderId'] ?? '',
      orderDate: data['orderDate'] ?? '',
      status: data['status'] ?? 'Pending',
      total: (data['total'] ?? 0).toDouble(),
      // itemCount: (data['items'] as List<dynamic>).length, // FIX HERE: Get list length instead of casting
      customerName: data['customerName'] ?? '',
      paymentMethod: data['paymentMethod'] ?? 'COD',
    );
  }
}
