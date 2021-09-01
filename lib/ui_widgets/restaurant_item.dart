import 'package:alofoodie/foodie/screens/restaurant.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class RestaurantItem extends StatelessWidget {
  final String id;
  final String name;
  final String image;
  final String city;
  final double rating;
  final int offer;
  final bool isActive;
  final int from;
  final int to;
  final int distance;
  final double margin;
  final double bottomMargin;

  const RestaurantItem({
    required this.id,
    required this.name,
    required this.image,
    required this.city,
    required this.isActive,
    required this.offer,
    required this.from,
    required this.to,
    required this.rating,
    required this.distance,
    required this.margin,
    required this.bottomMargin,
    Key? key,
  }) : super(key: key);

  void navigate(BuildContext context, active) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    active
        ? Navigator.of(context).pushNamed(Restaurant.routeName,
            arguments: [id, name, image, distance])
        : ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              duration: Duration(milliseconds: 500),
              content: Text("The Hotel is closed currently."),
              action: SnackBarAction(
                textColor: Colors.white,
                label: "Okay",
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    bool active = isActive == true &&
        from <= DateTime.now().hour &&
        to > DateTime.now().hour;

    return Card(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(
        top: 12,
        left: 12,
        bottom: bottomMargin,
        right: margin,
      ),
      child: InkWell(
        onTap: () => navigate(context, active),
        child: Container(
          width: 220,
          margin: EdgeInsets.all(6),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ColorFiltered(
                        colorFilter: active
                            ? ColorFilter.mode(
                                Colors.transparent,
                                BlendMode.multiply,
                              )
                            : ColorFilter.mode(
                                Colors.grey,
                                BlendMode.saturation,
                              ),
                        child: CachedNetworkImage(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: image,
                          placeholder: (ctx, url) => Image.asset(
                            "assets/fallback.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                        color: Colors.lightGreenAccent.shade700,
                      ),
                      child: Text(
                        "Upto $offer% OFF",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              color: Theme.of(context).primaryColor,
                              size: 22,
                            ),
                            Text(
                              "$rating",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(city),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
