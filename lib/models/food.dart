class Food {
  final String id;
  final String name;
  final String image;
  final String description;
  final String category;
  final bool veg;
  final List? addons;
  final List? toppings;
  final List? sizes;
  final List? buns;
  final int fixedPrice;
  final int offerPrice;
  final int packagingCharge;
  final int availableFrom;
  final int availableTo;
  final bool isActive;
  final double rating;
  final bool bestSeller;
  final String restaurantId;

  Food({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.veg,
    this.addons,
    this.toppings,
    this.sizes,
    this.buns,
    required this.fixedPrice,
    required this.offerPrice,
    required this.packagingCharge,
    required this.availableFrom,
    required this.availableTo,
    required this.isActive,
    required this.rating,
    required this.bestSeller,
    required this.restaurantId,
  });
}
