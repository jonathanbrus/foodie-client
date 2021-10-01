class CartItem {
  final String id;
  final String name;
  final String image;
  final int fixedPrice;
  final int offerPrice;
  final int packagingCharge;
  final int deliveryCharge;
  int quantity;
  String? addon;
  int addonPrice;
  String? topping;
  int toppingPrice;
  String? size;
  int sizePrice;
  String? bun;
  int bunPrice;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.fixedPrice,
    required this.offerPrice,
    required this.packagingCharge,
    required this.deliveryCharge,
    required this.quantity,
    this.addon,
    required this.addonPrice,
    this.topping,
    required this.toppingPrice,
    this.size,
    required this.sizePrice,
    this.bun,
    required this.bunPrice,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "addon": addon,
        "addonPrice": addonPrice,
        "topping": topping,
        "toppingPrice": toppingPrice,
        "size": size,
        "sizePrice": sizePrice,
        "bun": bun,
        "bunPrice": bunPrice,
        "fixedPrice": fixedPrice,
        "offerPrice": offerPrice,
        "packagingCharge": packagingCharge,
        "quantity": quantity,
      };
}
