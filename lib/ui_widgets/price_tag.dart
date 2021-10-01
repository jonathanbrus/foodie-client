import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final int fixedPrice;
  final int offerPrice;
  final double fixedPriceSize;
  final double offerPriceSize;
  final double offerPercentSize;

  const PriceTag({
    required this.fixedPrice,
    required this.offerPrice,
    required this.fixedPriceSize,
    required this.offerPriceSize,
    required this.offerPercentSize,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String offer =
        (((fixedPrice - offerPrice) / fixedPrice) * 100).toStringAsFixed(0);
    return Row(
      children: [
        Text(
          "\u{20B9}$fixedPrice",
          style: TextStyle(
            fontSize: fixedPriceSize,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.lineThrough,
            decorationThickness: 2,
            color: Colors.black45,
          ),
        ),
        SizedBox(width: 6),
        Text(
          "\u{20B9}$offerPrice",
          style: TextStyle(
            fontSize: offerPriceSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.32),
              borderRadius: BorderRadius.circular(3)),
          child: Text(
            offer + "% OFF",
            style: TextStyle(
              fontSize: offerPercentSize,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
        )
      ],
    );
  }
}
