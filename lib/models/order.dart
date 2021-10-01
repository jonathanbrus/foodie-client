class OrderItem {
  final String name;
  final String image;
  final int price;
  final int quantity;
  final String? addon;
  final String? topping;
  final String? size;
  final String? bun;

  OrderItem({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    this.addon,
    this.topping,
    this.size,
    this.bun,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "price": price,
        "quantity": quantity,
        "addon": addon,
        "topping": topping,
        "size": size,
        "bun": bun,
      };
}

class Order {
  final String id;
  final bool food;
  final String buyFrom;
  final List<OrderItem> orderItems;
  final Map shippingAddress;
  final String paymentMethod;
  final bool paid;
  final int deliveryCharge;
  final int taxAmount;
  final int totalAmount;
  String orderStatus;
  final DateTime createdAt;
  // final DateTime deliveredAt;

  Order({
    required this.id,
    required this.food,
    required this.buyFrom,
    required this.orderItems,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.paid,
    required this.deliveryCharge,
    required this.taxAmount,
    required this.totalAmount,
    required this.orderStatus,
    required this.createdAt,
    // required this.deliveredAt
  });
}
