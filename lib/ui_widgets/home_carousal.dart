import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeCarousel extends StatefulWidget {
  final String uri;
  final double screenHeight;

  const HomeCarousel({
    Key? key,
    required this.uri,
    required this.screenHeight,
  }) : super(key: key);

  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  List _slides = [
    "https://firebasestorage.googleapis.com/v0/b/alofoodie-13d05.appspot.com/o/sliders%2FCONSTANT%20POSTERS.jpg?alt=media&token=e33f29f7-3d9d-47f3-9b8e-6d66602b9168",
  ];

  fetchSlider() async {
    var url = Uri.parse(
        "https://alofoodie.herokuapp.com/images?imageFor=${widget.uri}");
    try {
      final response = await http.get(url);

      final decoded = json.decode(response.body);

      if (mounted) {
        setState(() {
          _slides = [..._slides, ...decoded["data"]];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: CarouselSlider(
        items: _slides
            .map(
              (slide) => Card(
                margin: EdgeInsets.only(bottom: 8),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: slide,
                    fit: BoxFit.fill,
                    placeholder: (ctx, url) => Image.asset(
                      "assets/fallback.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: widget.screenHeight * 0.28,
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayInterval: Duration(seconds: 5),
          viewportFraction: 0.96,
          autoPlayCurve: Curves.decelerate,
        ),
      ),
    );
  }
}
