class Product {
  final String id;
  final String name;
  final List image;
  final String description;
  final List productDetail;
  final int offerPrice;
  final int fixedPrice;
  final int deliveryCharge;
  final int itemsInStock;
  final String category;
  final String subCategory;
  final List sizes;
  final List colors;
  final double rating;
  final bool bestSeller;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.productDetail,
    required this.offerPrice,
    required this.fixedPrice,
    required this.deliveryCharge,
    required this.itemsInStock,
    required this.category,
    required this.subCategory,
    required this.sizes,
    required this.colors,
    required this.rating,
    required this.bestSeller,
  });
}
