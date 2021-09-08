import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

import 'cart.dart';

import '../ui_widgets/product_image_slider.dart';

import '../widgets/banner.dart';
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

  Future<void> addTo(cartProvider, user) async {
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
      token: user.authToken,
    );
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(CartScreen.routeName),
            icon: Icon(Icons.shopping_cart_rounded),
            splashColor: Colors.amber,
            splashRadius: 28,
          )
        ],
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
                  SizedBox(height: 4),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "${widget.product.fixedPrice}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "\u{20B9}${widget.product.offerPrice}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 6),
                      OfferTag(
                          offer: (((widget.product.fixedPrice -
                                          widget.product.offerPrice) /
                                      widget.product.fixedPrice) *
                                  100)
                              .toStringAsFixed(0)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    child: Text(
                      "Delivery charge \u{20B9}${widget.product.deliveryCharge} | Free delivery for Prime members",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    child: widget.product.itemsInStock < 10
                        ? Text(
                            "Only ${widget.product.itemsInStock} available in stock",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            "In Stock",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Description",
                          style: TextStyle(
                              fontSize: 17.6, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
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
            CustomBanner(),
            RelatedProducts(category: widget.product.subCategory),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<Cart>(
        builder: (ctx, cartProvider, ch) => Container(
          padding: EdgeInsets.all(6),
          child: Consumer<User>(
            builder: (ctx, user, ch) => Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(true == true
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded),
                    iconSize: 28,
                    splashRadius: 28,
                  ),
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (!_loading)
                        cartProvider.getAllProducts
                                .where((e) => e.id == widget.product.id)
                                .isEmpty
                            ? addTo(cartProvider, user)
                            : Navigator.of(context)
                                .pushNamed(CartScreen.routeName);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OfferTag extends StatelessWidget {
  const OfferTag({
    required this.offer,
    Key? key,
  }) : super(key: key);

  final String offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.32),
          borderRadius: BorderRadius.circular(3)),
      child: Text(
        offer + "% OFF",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.green[800],
        ),
      ),
    );
  }
}
