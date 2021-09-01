import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/auth.dart';

//widgets
import '../ui_widgets/cart_item.dart';
import '../ui_widgets/price_detail.dart';
import '../ui_widgets/loader_screen.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cart";
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _loading = true;

  void fetch(context, cartProvider) async {
    final token = Provider.of<Auth>(context).authToken;

    await cartProvider.myCart(token);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    fetch(context, cartProvider);

    return Scaffold(
      backgroundColor: cartProvider.getAllProducts.isEmpty
          ? Colors.white
          : Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                ...cartProvider.getAllProducts.map((cartItem) => CartListItem(
                      id: cartItem.id,
                      name: cartItem.name,
                      image: cartItem.image,
                      fixedPrice: cartItem.fixedPrice,
                      offerPrice: cartItem.offerPrice,
                      qunatity: cartItem.quantity,
                    )),
                (cartProvider.getAllProducts.isEmpty)
                    ? Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height - 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 160,
                              height: 200,
                              child: Image.asset(
                                "assets/cart.png",
                              ),
                            ),
                            Text(
                              "Your Cart Is Empty !",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(children: [
                          SizedBox(height: 10),
                          PriceDetail(
                            from: "",
                            noOfItems: cartProvider.getAllProducts.length,
                            itemsAmount: cartProvider.totalItemsAmount,
                            taxAmount: cartProvider.taxAmount,
                            packagingCharge: 0,
                            deliveryCharge: cartProvider.deliveryCharge,
                            freeDeliveryMargin: 499,
                          ),
                        ]),
                      ),
                // if (cartProvider.getAllProducts.isNotEmpty)
                //   Container(
                //     margin: EdgeInsets.symmetric(horizontal: 6),
                //     child: ElevatedButton.icon(
                //       onPressed: () {
                //         Navigator.of(context)
                //             .pushNamed(CheckOutScreen.routeName);
                //       },
                //       icon: Icon(Icons.check),
                //       label: Text("Proceed to Checkout"),
                //       style: ElevatedButton.styleFrom(
                //         primary: Theme.of(context).accentColor,
                //         padding: EdgeInsets.all(8),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(2),
                //         ),
                //       ),
                //     ),
                //   )
              ],
            ),
            if (_loading)
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: LoaderScreen(),
              ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigator(index: 3),
    );
  }
}
