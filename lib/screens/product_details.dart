import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

import 'cart.dart';

import '../ui_widgets/product_image_slider.dart';

import '../widgets/related_products.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "/product-detail";

  final Product product;
  const ProductDetailsScreen({required this.product, Key? key})
      : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _loading = false;

  Future<void> addTo(cartProvider, auth) async {
    setState(() {
      _loading = true;
    });
    await cartProvider.addToCart(
      id: widget.product.id,
      image: widget.product.image[0],
      name: widget.product.name,
      offerPrice: widget.product.offerPrice,
      fixedPrice: widget.product.fixedPrice,
      deliveryCharge: widget.product.deliveryCharge,
      token: auth.authToken,
    );
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            ProductImageSlider(images: widget.product.image),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "\u{20B9}${widget.product.offerPrice}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "\u{20B9}${widget.product.fixedPrice}",
                        style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(width: 6),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          (((widget.product.fixedPrice -
                                              widget.product.offerPrice) /
                                          widget.product.fixedPrice) *
                                      100)
                                  .toStringAsFixed(0) +
                              "% OFF",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Details",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ...widget.product.productDetail.map((detail) => Text(
                              "${widget.product.productDetail.indexOf(detail) + 1}. $detail",
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            RelatedProducts(category: widget.product.subCategory),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(6),
        child: Consumer<Auth>(
          builder: (ctx, auth, ch) => ElevatedButton.icon(
            onPressed: () {
              if (!_loading)
                cartProvider.getAllProducts
                        .where((e) => e.id == widget.product.id)
                        .isEmpty
                    ? addTo(cartProvider, auth)
                    : Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            icon: Icon(Icons.add_shopping_cart_rounded),
            label: Text(
              _loading
                  ? "Adding..."
                  : cartProvider.getAllProducts
                          .where((e) => e.id == widget.product.id)
                          .isEmpty
                      ? "Add To Cart"
                      : "Go To Cart",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(11),
              primary: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
