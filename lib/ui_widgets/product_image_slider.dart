import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductImageSlider extends StatefulWidget {
  final List images;

  const ProductImageSlider({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  _ProductImageSliderState createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          items: [
            ...widget.images.map(
              (image) => Container(
                width: double.infinity,
                child: FadeInImage(
                  placeholder: AssetImage("assets/fallback.jpg"),
                  image: NetworkImage(image),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
          options: CarouselOptions(
            onPageChanged: (int i, CarouselPageChangedReason r) {
              setState(() {
                _currentIndex = i;
              });
            },
            height: MediaQuery.of(context).size.height * 0.5,
            enableInfiniteScroll: widget.images.length > 1 ? true : false,
            viewportFraction: 1,
            autoPlayCurve: Curves.easeInOut,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.images.length; i++)
                  _currentIndex == i
                      ? CurrentIndicator()
                      : NotCurrentIndicator()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NotCurrentIndicator extends StatelessWidget {
  const NotCurrentIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7,
      width: 7,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
    );
  }
}

class CurrentIndicator extends StatelessWidget {
  const CurrentIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: 16,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
    );
  }
}
