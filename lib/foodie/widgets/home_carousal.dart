import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: CarouselSlider(
        items: slides
            .map(
              (slide) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(slide["image"]),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: screenHeight * 0.28,
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayInterval: Duration(seconds: 22),
          viewportFraction: 0.96,
          autoPlayCurve: Curves.decelerate,
        ),
      ),
    );
  }
}

const List slides = [
  {"image": "assets/sliders/1.jpg", "to": "foodie-home"},
  {"image": "assets/sliders/2.jpg", "to": "foodie-home"},
  {"image": "assets/sliders/3.jpg", "to": "foodie-home"},
  {"image": "assets/sliders/4.jpg", "to": "foodie-home"},
];
