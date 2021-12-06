class Restaurent {
  final String id;
  final String name;
  final String image;
  final String city;
  final bool popular;
  final List topPicks;
  final double rating;
  final int offer;
  final bool active;
  final int from;
  final int to;
  final int distance;

  Restaurent({
    required this.id,
    required this.name,
    required this.image,
    required this.city,
    required this.popular,
    required this.topPicks,
    required this.rating,
    required this.offer,
    required this.active,
    required this.from,
    required this.to,
    required this.distance,
  });
}
